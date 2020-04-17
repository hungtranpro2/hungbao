class OverviewCompanysController < ApplicationController
  before_action :authenticate_user!
  before_action :count_overview, only: [:index]
  def index
    @tasks = Task.where(parent_task: true, active: true)
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
    @project_count = Project.all.count
    @report_count = Report.all.count
    @task_count = Task.where(parent_task: true).count
  end
end
