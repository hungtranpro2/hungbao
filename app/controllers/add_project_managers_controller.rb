class AddProjectManagersController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find_by id: params[:id]
    @users = current_division.users.where.not(id: current_user.id).where(role: 0)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user_project = UserProject.new user_id: params[:user_id], project_id: params[:project_id], role: 1
    ActiveRecord::Base.transaction do
      @user_project.save!
      add_user_to_chat params[:user_id], params[:project_id]
      flash[:success] = "Thêm quản lý thành công"
      redirect_to company_projects_path
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Thêm quản lý thất bại"
      redirect_to root_path
    end
  end

  private

  def add_user_to_chat user_id, project_id
    user = User.find_by id: user_id
    project = Project.find_by id: project_id
    list = ListMessage.find_by name: project.name
    Message.create!(content: "#{user.name} đã tham gia dự án", list_message_id: list.id, user_id: user_id)
  end
end
