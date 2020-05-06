class ShowViewProgressController < ApplicationController
  def show
    @task = Task.find_by id: params[:id]
    @notifi = Notification.new
     respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @task = Task.find_by id: params[:id]
    if params[:is] == "true"
      ActiveRecord::Base.transaction do
        @task.progress = @task.notifications.last.progress if @task
        @task.update!(status: true)
        update_parent_task @task
        send_notification @task, "Tiến dộ này đã được chấp nhận"
        flash[:success] = "Đã cập nhật tiến độ"
        redirect_to division_tasks_path
      rescue ActiveRecord::RecordInvalid
        flash.now[:error] = "Cập nhật thất bại"
        render division_tasks_path
      end
    else
       ActiveRecord::Base.transaction do
        @task.update!(status: true)
        send_notification @task, "Tiến dộ này đã bị từ chối"
        flash[:success] = "cập nhật thành công"
        redirect_to division_tasks_path
      rescue ActiveRecord::RecordInvalid
        flash[:error] = "cập nhật thất bại"
        redirect_to division_tasks_path
      end
    end
  end

  private

  def send_notification task , content
    task.notifications.create!(title: content, sender_id: current_user.id, receiver_id: task.user.id)
  end

  def update_parent_task task
    @parent_task = task.parent
    @children_tasks = @parent_task.childrens.uniq

    sum_expected_day = @children_tasks.inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end

    sum_progress = @children_tasks.inject(0) do |sum, task|
       sum + task.progress*(task.start_time..task.end_time).count
    end

    parent_progress = (sum_progress.to_f / sum_expected_day).round(2)
    @parent_task.update!(progress: parent_progress.to_f)
  end
end
