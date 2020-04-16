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
    ActiveRecord::Base.transaction do
      @user_project.save!
      add_user_to_chat params[:user_id], @project
      flash[:success] = "Thêm quản lý bộ phận thành công"
      redirect_to company_projects_path
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Thêm quản lý bộ phận thất bại"
      redirect_to root_path
    end
  end

  private

  def add_user_to_chat user_id, project
    user = User.find_by id: user_id
    list = ListMessage.find_by name: project.name
    Message.create!(content: "#{user.name} đã tham gia dự án", list_message_id: list.id, user_id: user_id)
  end
end
