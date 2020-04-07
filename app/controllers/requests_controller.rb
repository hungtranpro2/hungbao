class RequestsController < ApplicationController
  before_action :authenticate_user!

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
    @request = current_user.personal_requests.new
  end


  def edit
    @request = current_user.personal_requests.find_by id: params[:id]
  end

  def create
    @request = current_user.personal_requests.new request_params
    if params[:personal_request][:time_from] > params[:personal_request][:time_to] ||  params[:personal_request][:time_to] > Time.now.to_s
      @request.errors.add(:time_from, "Thời gian bắt đầu và kết thúc không hợp lệ!")
      render :new
    else
      ActiveRecord::Base.transaction do
        @request.save!

        if !current_division.is_project? && current_user.member? || current_user.hr?
          send_division_manager
        elsif current_division.is_project? && current_user.member?
          send_project_manager
        elsif !current_division.is_project? && current_user.manager?
          send_project_leader
        end

        flash[:success] = "Tạo yêu cầu thành công"
        redirect_to requests_path
      rescue ActiveRecord::RecordInvalid
        flash.now[:error] = "Tạo yêu cầu thất bại"
        render :new
      end
    end
  end

  def update
     @request = current_user.personal_requests.find_by id: params[:id]
     if @request.status == "waiting"
       if @request.update(request_params)
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
    @request = current_user.personal_requests.find_by id: params[:id]
    if @request.status == "waiting"
      if @request.destroy
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

  def send_division_manager
    @approval_request = @request.approval_requests.create! division_id: current_division.id
    current_division.users.manager.each do |manager|
      @approval_request.notifications.create!(title: "Bạn có một yêu cầu mới", sender_id: current_user.id, receiver_id: manager.id)
    end
  end

  def send_project_leader
    @approval_request = @request.approval_requests.create! division_id: Division.where(is_project: true).first.id
    Division.where(is_project: true).first.users.member.each do |manager|
      @approval_request.notifications.create!(title: "Bạn có một yêu cầu mới", sender_id: current_user.id, receiver_id: manager.id)
    end
  end

  def send_project_manager
    @approval_request = @request.approval_requests.create! division_id: current_division.id
    current_division.users.manager.each do |manager|
      @approval_request.notifications.create!(title: "Bạn có một yêu cầu mới", sender_id: current_user.id, receiver_id: manager.id)
    end
  end

  def request_params
    params.require(:personal_request).permit PersonalRequest::PARAMS
  end

end
