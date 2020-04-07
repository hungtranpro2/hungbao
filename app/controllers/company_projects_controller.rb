class CompanyProjectsController < ApplicationController

  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result.paginate(page: params[:page], per_page: 5)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      flash[:success] = "Khởi tạo dự án thành công"
      redirect_to company_projects_path
    else
      flash[:error] = "Khởi tạo dự án thất bại"
      render :new
    end
  end

  def show
    @project = Project.find_by id: params[:id]
  end

  private

  def project_params
    params.require(:project).permit Project::PARAMS
  end

end
