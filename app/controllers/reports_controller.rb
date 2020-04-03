class ReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects if @projects.blank?
    @project = Project.find_by name: params[:project] if params[:project].present?
    @q = current_user.reports.where(project_id: @project.id).ransack(params[:q]) if @project.present?
    @q = current_user.reports.ransack(params[:q])
    @reports = @q.result.paginate(page: params[:page], per_page: 10)
  end

  def new
    @report = current_user.reports.new
  end

  def show
    @notifi = Notification.find_by id: params[:id]
    @notifi.update(seen: true)
  end

  def create
    @report = current_user.reports.new report_params
    @project_id = params[:report][:project_id]
    ActiveRecord::Base.transaction do
      @report.save!
      send_notification @report, @project_id
      flash[:success] = "Tạo báo cáo thành công"
      redirect_to reports_path
    rescue ActiveRecord::RecordInvalid
      flash.now[:error] = "Tạo báo cáo thất bại"
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit Report::PARAMS
  end

  def send_notification report, project_id
    @project = Project.find_by(id: project_id)
    current_division.users.manager.each do |manager|
      report.notifications.create!(title: report.title, sender_id: current_user.id, receiver_id: manager.id)
    end

    @project.users.where(division_id: 1).each do |manager|
      report.notifications.create!(title: report.title, sender_id: current_user.id, receiver_id: manager.id)
    end
  end
end
