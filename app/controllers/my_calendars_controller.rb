class MyCalendarsController < ApplicationController
  before_action :authenticate_user!

  def index
    @children_tasks = current_user.tasks.where(active: true, parent_task: false)
  end

  def show
    @children_tasks = current_user.tasks.where(active: true, parent_task: false)
    if params[:id] == "month"
      @type = "month"
    else
      @type = "week"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
