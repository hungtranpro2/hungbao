class ProjectReportsController < ApplicationController
   before_action :authenticate_user!
  before_action :correct_project_leader

  def index
    @q = current_user.projects.first.reports.ransack(params[:q])
    @reports = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end

  private
  def correct_project_leader
    unless current_user.member? && current_division.is_project?
      redirect_to root_path
    end
  end
end
