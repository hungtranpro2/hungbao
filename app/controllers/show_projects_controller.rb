class ShowProjectsController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    @projects = current_user.projects.where.not(id: @user.projects).uniq
    @user_project = UserProject.new
    respond_to do |format|
      format.html
      format.js
    end
  end

end
