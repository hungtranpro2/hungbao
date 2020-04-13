class MyWorksController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_user.tasks.where(parent_task: false).ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 7)
    overview @tasks
  end

  def new
    @task = current_user.tasks.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @task = Task.new task_params
    if params[:task][:start_time] <= Time.now.to_s || params[:task][:start_time] > params[:task][:end_time]
      @task.errors.add(:time_start, "time exceeding")
      render :new
    else
      if @task.save
        flash[:success] = "Bạn tạo task thành công"
        redirect_to my_works_path
      else
        render :new
      end
    end
  end

  private

  def task_params
    params.require(:task).permit MyWork::PARAMS
  end

  def overview tasks
    @sum_days = tasks.inject(0) do |sum , task|
      sum + (task.start_time..task.end_time).count
    end
  end
end
