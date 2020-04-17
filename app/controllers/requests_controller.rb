class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_project

  def index
    @q = current_user.personal_requests.ransack(params[:q])
    @requests = @q.result.paginate(page: params[:page],per_page: 10)
  end

  def show
    @request = PersonalRequest.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @personal_request = current_user.personal_requests.new
    respond_to do |format|
      format.html
      format.js
    end
  end


  def edit
    @personal_request = current_user.personal_requests.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @personal_request = current_user.personal_requests.new request_params
    ActiveRecord::Base.transaction do
      @personal_request.save!
      if !current_division.is_project? && current_user.member? || current_user.hr?
        send_division_manager @personal_request
      elsif !current_division.is_project? && current_user.manager?
        send_project_leader params[:personal_request][:project_id], @personal_request
      end

      flash[:success] = "Tạo yêu cầu thành công"
      redirect_to requests_path
    rescue ActiveRecord::RecordInvalid
      render :new
    end
  end

  def update
     @personal_request = current_user.personal_requests.find_by id: params[:id]
     if @personal_request.status == "waiting"
       if @personal_request.update(request_params)
          flash[:success] = "Cập nhật yêu cầu thành công"
          redirect_to requests_path
       else
          flash.now[:failure] = "Cập nhật yêu cầu thất bại "
          render :edit
       end
    else
      flash[:error] = "Bạn không thể thay đổi yêu cầu "
      redirect_to requests_path
    end
  end

  def destroy
    @personal_request = current_user.personal_requests.find_by id: params[:id]
    if @personal_request.status == "waiting"
      if @personal_request.destroy
        flash[:success] = "Xóa yêu cầu thành công"
        redirect_to requests_path
      else
        flash[:failure] = "Xóa yêu cầu thất bại"
        redirect_to errors_path
      end
    else
      flash[:error] = "Bạn không thể xóa yêu cầu này"
      redirect_to requests_path
    end
  end

  private

  def send_division_manager request
    @approval_request = request.approval_requests.create! division_id: current_division.id
    current_division.users.manager.each do |manager|
      @approval_request.notifications.create!(title: "Bạn có một yêu cầu mới", sender_id: current_user.id, receiver_id: manager.id)
    end
  end

  def send_project_leader project_id, request
    @approval_request = request.approval_requests.create! division_id: Division.where(is_project: true).first.id
    @project = Project.find_by id: project_id
    @project.users.where(division_id: Division.where(is_project: true)).each do |manager|
      @approval_request.notifications.create!(title: "Bạn có một yêu cầu mới", sender_id: current_user.id, receiver_id: manager.id)
    end
  end

  # def send_project_manager
  #   @approval_request = @request.approval_requests.create! division_id: current_division.id
  #   current_division.users.manager.each do |manager|
  #     @approval_request.notifications.create!(title: "Bạn có một yêu cầu mới", sender_id: current_user.id, receiver_id: manager.id)
  #   end
  # end

  def request_params
    params.require(:personal_request).permit PersonalRequest::PARAMS
  end

  def correct_project
    if current_user.member? && current_user.projects.blank?
      redirect_to root_path
    end
  end
end
