class PersonalProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
    if params[:name]
      @project = Project.find_by name: params[:name]
      @users = @project.users.paginate(page: params[:page], per_page: 15)
    else
      @users = current_user.projects.first.users.paginate(page: params[:page], per_page: 15)
    end
  end

end
