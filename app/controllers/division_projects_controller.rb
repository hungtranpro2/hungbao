class DivisionProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_division.projects.uniq
    @tasks = current_division.projects.first.tasks.where(parent_task: true).uniq
  end

  def show
    @projects = current_division.projects.uniq
    @tasks = current_division.projects.where(id: params[:id]).first.tasks.where(parent_task: true).uniq
    respond_to do |format|
      format.html
      format.js
    end
  end
end
