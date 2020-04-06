class AddProjectDivisionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find_by id: params[:id]
    @q = User.where(role: 1).where.not(division_id: current_division.id).ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def create
    @project = Project.find_by id: params[:project_id]
    if @project.users.present?
      @user_project = UserProject.new user_id: params[:user_id], project_id: params[:project_id]
      if @user_project.save
        flash[:success] = "Thêm quản lý bộ phận thành công"
        redirect_to project_member_path(params[:project_id])
      else
        flash[:error] = "Thêm quản lý bộ phận thất bại"
        redirect_to root_path
      end
    else
      flash[:error] = "Dự án này chưa có người quản lý"
      redirect_to project_member_path(params[:project_id])
    end
  end
end
