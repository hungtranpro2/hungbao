class PersonalTasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_task, only: [:show]
  # before_action :overview, only:[:index]
  # before_action :overview_now, only: [:index]

  def index
    @projects = current_user.projects
    @q = current_user.tasks.where(active: true).ransack(params[:q])
    @tasks = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
    overview @tasks
    # overview_now @tasks
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
    @parent_task = current_user.tasks.find_by id: params[:task][:parent_id]
    @task = Task.new task_params.merge(progress: params[:task][:progress].to_i, project_id: @parent_task.project_id)
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

  def overview tasks
    # tổng số task dự kiến
    @children_tasks = tasks.where(parent_task: false).uniq
    # tổng số ngày dự kiến
    @count_day = tasks.where(parent_task: false).inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end
    # thời gian và tiến độ hiện tại
    @now_day = tasks.where(parent_task: false).inject(0) do |sum, task|
      (task.end_time < Date.today) ? sum + (task.start_time..task.end_time).count : sum + (task.start_time..Date.today).count
    end
    # thời gian và tiến độ thực tế
    @sum_progress = tasks.where(parent_task: false).inject(0) do |sum, task|
       sum + task.progress*(task.start_time..task.end_time).count
    end

    @progress = (@sum_progress.to_f / @count_day).round(2)
  end
end
