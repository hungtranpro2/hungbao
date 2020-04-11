class ProjectMembersController < ApplicationController
   before_action :authenticate_user!

  def index

  end

  def show
    @project = Project.find_by id: params[:id]
    @q = @project.users.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    @user_project = UserProject.find_by user_id: params[:user_id], project_id: params[:project_id]
    if @user_project.destroy
      flash[:success] = "Bạn đã xóa thành công thành viên này"
      redirect_to project_member_path(params[:project_id])
    else
      flash[:error] = "Bạn đã xóa thất bại thành viên này"
      redirect_to root_path
    end
  end
end
