class ProjectReportsController < ApplicationController
   before_action :authenticate_user!

  def index
    @q = current_user.projects.first.reports.ransack(params[:q])
    @reports = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end
end
