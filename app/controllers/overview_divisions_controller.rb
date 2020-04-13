class OverviewDivisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :count_overview, only: [:index]
  def index
    @tasks = current_division.tasks.where(parent_task: true, active: true)
    time_line @tasks
    @children_tasks = current_division.tasks.where(parent_task: false, active: true).where.not(project_id: nil)
  end

  private
  def time_line tasks
    @time_line = []
    tasks.each do |task|
      @time_line.push(["#{task.title}", "#{task.start_time}", "#{task.end_time + 1.days}"])
    end
  end

  def count_overview
    @sum_request = current_division.approval_requests.count
    @member_count = current_division.users.uniq.count
    @project_count = current_division.projects.uniq.count
    @report_count = current_division.reports.uniq.count
    @task_count = current_division.tasks.uniq.count
  end
end
