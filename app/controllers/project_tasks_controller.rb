class ProjectTasksController < ApplicationController
   before_action :authenticate_user!
   before_action :correct_project_leader
  def index
    @q = current_user.projects.first.tasks.where.not(project_id: nil).where(parent_task: true).ransack(params[:q])
    @tasks = @q.result.paginate(page: params[:page], per_page: 10)
  end

  private
  def correct_project_leader
    unless current_user.member? && current_division.is_project?
      redirect_to root_path
    end
  end
end
