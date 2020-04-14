class AddProjectManagersController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find_by id: params[:id]
    @users =current_division.users.where.not(id: current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user_project = UserProject.new user_id: params[:user_id], project_id: params[:project_id], role: 1
    if @user_project.save
      flash[:success] = "Thêm quản lý thành công"
      redirect_to company_projects_path
    else
      flash[:error] = "Thêm quản lý thất bại"
      redirect_to root_path
    end
  end
end
