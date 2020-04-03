class ShowReportsController < ApplicationController
  def show
    @report = Report.find_by id: params[:id]
  end
  respond_to do |format|
    format.html
    format.js
  end
end
