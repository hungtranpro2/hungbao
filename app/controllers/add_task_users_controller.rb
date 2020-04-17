class AddTaskUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_task, only: [:show]

  def show
    @project = Project.find_by id: @task.project_id
    @users = @project.users.where(division_id: current_division).where.not(id: current_user.id).uniq
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @task = Task.find_by id: params[:task][:id]
    if @task.update(user_id: params[:task][:user_id], parent_task: true)
      flash[:success] = "Phân task cho thành viên thành công"
      redirect_to division_tasks_path
    else
      flash[:error] = "Phân task cho thành viên tất bại!"
      redirect_to errors_path
    end
  end

  private

  def correct_task
    @task = Task.find_by id: params[:id]
    return @task if @task.present?

    flash[:error] = "Dự án này không tồn tại"
    redirect_to errors_path
  end
end
