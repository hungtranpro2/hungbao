class AddMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :manager_user

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find_by id: params[:id]
    @user_project = UserProject.new
    @projects = Project.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
     @user_group = UserProject.new user_project_params
    if @user_group.save
      flash[:success] = "Add Member to Group Success"
      redirect_to add_members_path
    else
      flash[:error] = "Add Member to Group Failure"
      redirect_to errors_path
    end
  end

  private

  # def project_childrents_select(user)
  #   @groups = []
  #   load_group(current_division)
  #   @groups.flatten - user.groups
  # end

  # def load_group(division)
  #   if division.childrens.blank?
  #     @groups.push(division.groups)
  #   else
  #     division.childrens.each do |i|
  #       load_group(i)
  #     end
  #   end
  # end

  def manager_user
    redirect_to root_path unless current_user.manager?
  end

  def user_project_params
    params.require(:user_project).permit UserProject::PARAMS
  end
end
