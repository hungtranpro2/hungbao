class ProjectRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_user.projects.first&.project_requests.ransack(params[:q])
    @requests = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end

  def new
    @request = ProjectRequest.new
    respond_to do |format|
      format.html
      format.js
    end
  end
end
