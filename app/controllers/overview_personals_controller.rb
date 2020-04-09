class OverviewPersonalsController < ApplicationController
  before_action :authenticate_user!

  def show
    @project = Project.find_by id: params[:id]
    @project_member = @project.users.count
    @report_count = @project.reports.count
  end
end
