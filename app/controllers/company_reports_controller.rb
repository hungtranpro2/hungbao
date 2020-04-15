class CompanyReportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Report.all.ransack(params[:q])
    @reports = @q.result(distinct: true).paginate(page: params[:page], per_page: 7)
  end
end
