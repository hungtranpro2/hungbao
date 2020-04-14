class ProjectTasksController < ApplicationController
   before_action :authenticate_user!

  def index
    @q = current_user.projects.first.tasks.where.not(project_id: nil).ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 10)
  end
end
