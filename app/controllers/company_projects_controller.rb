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
    # @leaders = @project.users.where(@project.user_projects.where(role: 1))
  end


  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = "Khởi tạo dự án thành công"
      redirect_to company_projects_path
    else
      flash[:error] = "Khởi tạo dự án thất bại"
      respond_to do |format|
        format.html
        format.js{render :new}
      end
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
    if @project.destroy
      flash[:success] = "Xóa dự án thành công"
      redirect_to company_projects_path
    else
      flash[:success] = "Xóa dự án thất bại"
      redirect_to root_path
    end
  end

  private

  def project_params
    params.require(:project).permit Project::PARAMS
  end

end
