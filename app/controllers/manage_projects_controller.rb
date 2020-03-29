class ManageProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_group, only: [:destroy, :update]

  def index
    @q = Project.ransack(params[:q])
    @groups = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @group = current_division.projects.new
  end

  def show
    @group = Project.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @group = Project.find_by id: params[:id]
    @path = params[:path]
  end

  def create
    @group = current_division.projects.new group_params
    if @group.save
      flash[:success] = "Tạo dự án thành công"
      redirect_to manage_projects_path
    else
      flash[:error] = "Tạo dự án thất bại"
      render :new
    end
  end

  def update
    if @group.update(group_params)
      flash[:success] = "Cập nhật dự án thành công"
      redirect_to manage_projects_path
    else
      flash[:error] = t "Cập nhật dự án thất bại"
      redirect_to root_path
    end
  end

  def destroy
    if @group.destroy
      flash[:success] = "Xóa dự án thành công"
      redirect_to request.referer || root_path
    else
      flash[:error] = "Xóa dự án thất bại"
      redirect_to root_path
    end
  end

  private

  def correct_group
    @group = Project.find_by id: params[:id]
    return if @group

    flash[:error] = t "admin_manage_users.not_exits"
    redirect_to root_path
  end

  def group_params
    params.require(:project).permit Project::PARAMS
  end
end
