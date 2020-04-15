class CompanyMembersController < ApplicationController
  def index
    @q = User.where.not(projects: present?).ransack(params[:q])
    @users = @q.result.paginate(page: params[:page], per_page: 10)
  end
end
