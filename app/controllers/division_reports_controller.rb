class DivisionReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_division.reports.ransack(params[:q])
    @reports = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end
end
