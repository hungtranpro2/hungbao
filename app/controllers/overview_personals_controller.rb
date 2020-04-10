class OverviewPersonalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @count_task = current_user.tasks.count
    @count_request = current_user.personal_requests.count
    @count_report = current_user.reports.count
    @count_project = current_user.projects.uniq.count
  end
end
