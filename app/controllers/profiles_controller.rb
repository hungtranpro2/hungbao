class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by id: params[:id]
    @notification = current_user.notifications.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update(user_params)
      flash.now[:success] = "Cập nhật thành công"
      redirect_to profile_path(@user)
    else
      flash.now[:error] = "Cập nhật thất bại"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::PARAMS_PROFILE
  end
end
