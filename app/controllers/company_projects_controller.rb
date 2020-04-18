class CompanyProjectsController < ApplicationController

  before_action :authenticate_user!

  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result.paginate(page: params[:page], per_page: 5)
  end

  def new
    @project = Project.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @project = Project.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
    # @leaders = @project.users.where(@project.user_projects.where(role: 1))
  end


  def create
    @project = Project.new project_params
    ActiveRecord::Base.transaction do
      @project.save!
      create_room_chat @project
      flash[:success] = "Khởi tạo dự án thành công"
      redirect_to company_projects_path
    rescue ActiveRecord::RecordInvalid
      render :new
    end
  end

  def edit
    @project = Project.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @project = Project.find_by id: params[:id]
    if @project.update project_params
      flash[:success] = "Cập nhật dự án thành công"
      redirect_to company_projects_path
    else
      flash[:error] = "Cập nhật dự án thất bại"
      render :edit
    end
  end

  def destroy
    @project = Project.find_by id: params[:id]
    ActiveRecord::Base.transaction do
      @project.destroy!
      delete_room_chat @project
      flash[:success] = "Xóa dự án thành công"
      redirect_to company_projects_path
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Xóa dự án thất bại"
      redirect_to root_path
    end
  end

  private

  def create_room_chat project
    list = ListMessage.create!(name: project.name, type_mes: 1)
    Message.create!(content: "#{current_user.name} đã tham gia dự án", list_message_id: list.id, user_id: current_user.id)
  end

  def delete_room_chat project
    @list = ListMessage.find_by name: project.name
    @list.destroy! if @list.present?
  end

  def project_params
    params.require(:project).permit Project::PARAMS
  end

  def correct_boss
    unless current_user.manager? && current_division.is_project?
      redirect_to root_path
    end
  end
end
