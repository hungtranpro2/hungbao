class OverviewPersonalsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_member

  def index
    @count_request = current_user.personal_requests.count
    @count_report = current_user.reports.count
    @count_project = current_user.projects.uniq.count

    @tasks = current_user.tasks.where(active: true, parent_task: false).where.not(project_id: nil)
    time_line @tasks
    overview @tasks
  end
  private

  def time_line tasks
    @time_line = []
    tasks.each do |task|
      @time_line.push(["#{task.title}", "#{task.start_time}", "#{task.end_time + 1.days}"])
    end
  end

  def overview tasks
    #members
    @count_users = current_user.projects.uniq.inject(0) do |sum, project|
       sum + project.users.count
    end
    # tổng số task dự kiến
    @children_tasks = tasks.where(parent_task: false).uniq
    # tổng số ngày dự kiến
    @count_day = tasks.where(parent_task: false).inject(0) do |sum, task|
      sum + (task.start_time..task.end_time).count
    end
    # thời gian và tiến độ hiện tại
    @now_day = tasks.where(parent_task: false).inject(0) do |sum, task|
      (task.end_time < Date.today) ? sum + (task.start_time..task.end_time).count : sum + (task.start_time..Date.today).count
    end
    # thời gian và tiến độ thực tế
    @sum_progress = tasks.where(parent_task: false).inject(0) do |sum, task|
       sum + task.progress*(task.start_time..task.end_time).count
    end

    @progress = (@sum_progress.to_f / @count_day).round(2)
  end

  def correct_member
    unless current_user.member? && !current_division.is_project?
      redirect_to root_path
    end
  end
end
