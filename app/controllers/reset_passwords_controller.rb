class ResetPasswordsController < ApplicationController
    def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]
    if params[:user][:password].empty?
      @user.errors.add(:password,"can't be empty")
      flash.now[:error] = "Password can't empty"
      render :edit
    elsif params[:user][:password] != params[:user][:password_confirmation]
      @user.errors.add(:password, "false confirmation")
      flash.now[:error] = "False confirmation"
      render :edit
    elsif @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = "Password has been reset."
      redirect_to edit_profile_path(@user)
    else
      flash.now[:error] = "Password reset failed"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::PARAMS_PASSWORD
  end
end
