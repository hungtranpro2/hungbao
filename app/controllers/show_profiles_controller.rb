class ShowProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end
end
