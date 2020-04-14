class UserManagersController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @division = 1
    @user = User.new user_params
    if @user.save
      flash[:success] = "Tạo user thành công"
      redirect_to user_managers_path
    else
      flash[:error] = "Tạo user thất bại"
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update user_params
      flash[:success] = "Cập nhật user thành công"
      redirect_to user_managers_path
    else
      flash[:error] = "Cập nhật user thất bại"
      redirect_to user_managers_path
    end
  end


  def destroy
    @user = User.find_by id: params[:id]
    if @user.destroy
      flash[:success] = "Xóa user thành công"
      redirect_to user_managers_path
    else
      flash[:success] = "Xóa user thất bại"
      redirect_to user_managers_path
    end
  end

  private

  def user_params
    params.require(:user).permit User::PARAMS_USER
  end

end
