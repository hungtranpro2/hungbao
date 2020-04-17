class DivisionTasksController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_project, only: [:show]
  before_action :manager
  before_action :correct_team_leader

  def index
    @projects = current_division.projects.uniq
    @q = current_division.tasks.where.not(project_id: nil).ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @task = current_user.tasks.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @task = Task.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @task = Task.new task_params.merge(parent_task: true, progress: params[:task][:progress].to_i)
    if params[:task][:start_time] < Time.now.to_s || params[:task][:start_time] > params[:task][:end_time]
      @task.errors.add(:time_start, "not is valid")
      render :new
    else
      if @task.save
        flash[:success] = "Bạn tạo tag thành công"
        redirect_to division_tasks_path
      else
        flash.now[:error] = "Bạn tạo tag thất bại"
        render :new
      end
    end
  end

  def update
    @task = Task.find_by id: params[:id]
    @task.lock = params[:task][:lock]
    if @task.update(task_params)
      flash[:success] = "Cập nhật thành công"
      redirect_to division_tasks_path
    else
      flash.now[:error] = "Cập nhật thất bại"
      render :edit
    end
  end

  def destroy
    @task = Task.find_by id: params[:id]
    if @task.destroy
      flash[:success] = "Xóa thành công"
      redirect_to division_tasks_path
    else
      flash.now[:error] = "Xóa thất bại"
      redirect_to errors_path
    end
  end

  private

  def manager
    if !current_user.manager?
      redirect_to root_path
    end
  end

  def task_params
    params.require(:task).permit Task::PARAMS
  end

  def correct_team_leader
    unless current_user.manager? && !current_division.is_project?
      redirect_to root_path
    end
  end
end
