class DivisionTasksController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_project, only: [:show]

  def index
    @projects = current_division.projects.uniq
    @q = Task.ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 7)
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = Task.new task_params
    if params[:task][:start_time] < Time.now.to_s
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

  private

  def correct_project
    @project = Project.find_by id: params[:id]
    return if @project.present?
    flash[:error] = "Trang này không tồn tại"
    redirect_to errors_path
  end

  def task_params
    params.require(:task).permit Task::PARAMS
  end
end
