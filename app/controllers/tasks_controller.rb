class TasksController < ApplicationController
  before_action :set_project
  def index
    @q = Task.where(project_id: 1).ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 5)
  end

  def new
    @task = Task.new(project_id: 1, user_id: 1)
  end

  def create
    @task = Task.new task_params
    if @task.save
      flash[:success] = "Tạo task thành công"
      redirect_to company_project_tasks_path
    else
      flash[:error] = "Tạo task thất bại"
      render :new
    end
  end

  def edit
    @task = Task.find_by id: params[:id]
  end

  private

  def set_project
    @project = Project.find_by(id: params[:project_id])
  end

  def task_params
    params.require(:task).permit Task::PARAMS
  end
end
