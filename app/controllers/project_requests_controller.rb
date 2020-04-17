class ProjectRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_project_leader

  def index
    if current_user.member?
      @q = current_user.projects.first&.project_requests.ransack(params[:q])
      @requests = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
    else
      @q = current_division.project_requests.ransack(params[:q])
      @requests = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
    end
  end

  def show
    @project_request = ProjectRequest.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @project_request = ProjectRequest.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @project_request = current_user.projects.first.project_requests.new params_project_request
    if @project_request.save
      flash[:success] = "Bạn tạo yêu cầu thành công"
      redirect_to project_requests_path
    else
      render :new
    end
  end

  def edit
    @project_request = ProjectRequest.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @project_request = ProjectRequest.find_by id: params[:id]
    params_project_request.merge(project_id: current_user.projects.first.id)
    if @project_request.update params_project_request
      flash[:success] = "Cập nhật thành công"
      redirect_to project_requests_path
    else
      render :edit
    end

  end

  private

  def params_project_request
    params.require(:project_request).permit ProjectRequest::PARAMS
  end

  def correct_project_leader
    unless current_user.member? && current_division.is_project?
      redirect_to root_path
    end
  end
end
