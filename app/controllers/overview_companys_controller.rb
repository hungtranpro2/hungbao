class OverviewCompanysController < ApplicationController
  before_action :authenticate_user!
  before_action :count_overview, only: [:index]
  before_action :time_line, only: [:index]
  before_action :pie_chart_project, only: [:index]
  before_action :correct_boss

  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end

  private

  def time_line
    @time_line = []
    @projects = Project.all
    @projects.each do |project|
      start_time = project.tasks.where(parent_task: true).minimum('start_time')
      end_time = project.tasks.where(parent_task: true).maximum('end_time')
      if start_time.present? && end_time.present?
        @time_line.push(["#{project.name}", "#{start_time}", "#{end_time + 1.days}"])
      end
    end
  end

  def pie_chart_project
    @pie_chart_project = []
    @projects = Project.all
    @projects.each do |project|
      pie_chart_division = []
      project.divisions.uniq.each do |division|
        pie_chart_division.push(["#{division.name}", "#{division.users.where(id: project.users).count}"])
      end
      @pie_chart_project.push(pie_chart_division)
    end
    @sum_pie = @pie_chart_project.count - 1
  end

  def count_overview
    @project_count = Project.all.count
    @report_count = Report.all.count
  end

  def correct_boss
    unless current_user.manager? && current_division.is_project?
      redirect_to root_path
    end
  end
end
