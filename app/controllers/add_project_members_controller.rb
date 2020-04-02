class AddProjectMembersController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find_by id: params[:id]
    @q = User.where.not(division_id: current_division.id).where(role: 0).ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end
end
