class DivisionMembersController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_division.users.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end


  def create
    @user_project = UserProject.new user_project_params

    ActiveRecord::Base.transaction do
      @user_project.save!
      add_user_to_chat params[:user_project][:user_id], params[:user_project][:project_id]
      flash[:success] = "Thêm thành viên vào dự án thành công"
      redirect_to division_members_path
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Thêm thành viên vào dự án thất bại"
      redirect_to root_path
    end
  end

  private

  def add_user_to_chat user_id, project_id
    user = User.find_by id: user_id
    project = Project.find_by id: project_id
    list = ListMessage.find_by name: project.name
    Message.create!(content: "#{user.name} đã tham gia dự án", list_message_id: list.id, user_id: user_id)
  end

  def user_project_params
    params.require(:user_project).permit UserProject::PARAMS
  end
end
