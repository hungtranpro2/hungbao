class DivisionProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_division.projects.ransack(params[:q])
    @projects = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end
end
