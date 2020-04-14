class AddProjectDivisionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find_by id: params[:id]
    @users =User.where(role: 1).where.not(division_id: current_division.id)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @project = Project.find_by id: params[:project_id]
    @user_project = UserProject.new user_id: params[:user_id], project_id: params[:project_id]
    if @user_project.save
      flash[:success] = "Thêm quản lý bộ phận thành công"
      redirect_to company_projects_path
    else
      flash[:error] = "Thêm quản lý bộ phận thất bại"
      redirect_to root_path
    end
  end
end
