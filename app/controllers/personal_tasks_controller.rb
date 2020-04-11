class PersonalTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_task, only: [:show]

  def index
    @projects = current_user.projects
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
    @children_tasks = current_user.tasks.where(parent_task: false).uniq
  end

  def new
    @task = current_user.tasks.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @task = Task.new task_params.merge(progress: params[:task][:progress].to_i)
    @parent_task = current_user.tasks.find_by id: params[:task][:parent_id]
    is_time =  @task.start_time.to_s < @parent_task.start_time.to_s || @task.end_time.to_s > @parent_task.end_time.to_s
    if current_user.tasks.where(parent_task: false).where("? <= end_time AND ? >= start_time", params[:task][:start_time], params[:task][:end_time]).present?
      @task.errors.add(:time_start, "time has coincided")
      render :new
    elsif is_time
      @task.errors.add(:time_start, "time exceeding")
      render :new
    else
      if @task.save

        flash[:success] = "Bạn tạo task thành công"
        redirect_to personal_tasks_path
      else
        render :new
      end
    end
  end

  private

  def task_params
    params.require(:task).permit Task::PARAMS
  end

  def correct_task
    @task = Task.find_by id: params[:id]
    return @task if @task.present?

    flash[:error] = "Task không tồn tại"
    redirect_to errors_path
  end
end
