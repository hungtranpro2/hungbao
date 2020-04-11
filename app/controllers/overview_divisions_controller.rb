class OverviewDivisionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @member_count = current_division.users.uniq.count
    @project_count = current_division.projects.uniq.count
    @report_count = current_division.reports.uniq.count
    @task_count = current_division.tasks.uniq.count
  end
end
