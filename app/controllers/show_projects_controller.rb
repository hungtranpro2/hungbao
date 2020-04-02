class ShowProjectsController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    @projects = current_division.projects.where.not(id: @user.projects)
    @user_project = UserProject.new
    respond_to do |format|
      format.html
      format.js
    end
  end

end
