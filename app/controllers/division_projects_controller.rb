class DivisionProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_team_leader

  def index
    @q = current_division.projects.ransack(params[:q])
    @projects = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end

  private
  def correct_team_leader
    unless current_user.manager? && !current_division.is_project?
      redirect_to root_path
    end
  end
end
