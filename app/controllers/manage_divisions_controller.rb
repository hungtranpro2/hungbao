class ManageDivisionsController < ApplicationController
  def index
    @q = current_division.users.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end


  def create
    @user_project = UserProject.new user_project_params
    if @user_project.save
      flash[:success] = "Thêm thành viên vào dự án thành công"
      redirect_to manage_divisions_path
    else
      flash[:error] = "Thêm thành viên vào dự án thất bại"
      redirect_to root_path
    end
  end

  private

  def user_project_params
    params.require(:user_project).permit UserProject::PARAMS
  end
end
