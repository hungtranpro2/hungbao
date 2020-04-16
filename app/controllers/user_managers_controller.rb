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
    @user = User.new user_params

    ActiveRecord::Base.transaction do
      @user.save!
      create_my_chat @user.id
      flash[:success] = "Tạo user thành công"
      redirect_to user_managers_path
    rescue ActiveRecord::RecordInvalid
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

   def create_my_chat user_id
    user = User.find_by id: user_id
    list = ListMessage.where(type_mes: 2).first
    Message.create!(content: "Hi #{user.name}", list_message_id: list.id, user_id: user_id)
  end

  def user_params
    params.require(:user).permit User::PARAMS_USER
  end

end
