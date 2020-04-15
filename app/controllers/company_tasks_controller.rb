class CompanyTasksController < ApplicationController
  def index
    @projects = Project.all
    @q = Task.where(parent_task: true).ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 10)
  end
end
