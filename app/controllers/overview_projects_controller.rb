class OverviewProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :count_overview, only: [:index]

  def index
    @tasks = current_user.projects.first.tasks.where(parent_task: true, active: true)
    @divisions = current_user.projects.first.divisions.uniq
    time_line @tasks
    pie_chart_division @divisions, current_user.projects.first
    pie_chart_task_division @divisions
  end

  private

  def pie_chart_task_division divisions
    @pie_chart_task_division = []
    divisions.each do |division|
      @pie_chart_task_division.push(["#{division.name}", "#{sum_task(division.tasks.where(parent_task: true))}"])
    end
  end

  def sum_task tasks
    # progress = tasks.inject(0) do |sum, task|
    #   sum + task.progress * (task.start_time..task.end_time).count
    # end

    days = tasks.inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end
    return days if days != 0
    return 0
  end

  def pie_chart_division divisions, project
    @pie_chart_division = []
    divisions.each do |division|
      @pie_chart_division.push(["#{division.name}", "#{division.users.where(id: project.users).count}"])
    end
  end

  def time_line tasks
    @time_line = []
    tasks.each do |task|
      @time_line.push(["#{task.title}", "#{task.start_time}", "#{task.end_time + 1.days}"])
    end
  end

  def count_overview
    @sum_request = current_division.approval_requests.where(send_for: 0).uniq.count
    @sum_member = current_user.projects.first.users.uniq.count
    @sum_report = current_user.projects.first.reports.uniq.count
    @sum_task = current_user.projects.first.tasks.where(parent_task: true).uniq.count
  end
end
