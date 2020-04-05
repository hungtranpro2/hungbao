class ApprovalRequestsController < ApplicationController
  def index
    if current_division.is_project? && current_user.manager?
      @q = current_division.approval_requests.where(send_for: 0).ransack(params[:q])
    else
      @q = current_division.approval_requests.ransack(params[:q])
    end
    @requests = @q.result.paginate(page: params[:page],per_page: 10)
  end

  def update
    @approval_request = ApprovalRequest.find_by id: params[:id]
    if @approval_request.status == "waiting"
      ActiveRecord::Base.transaction do
        @approval_request.update!(status: params[:status])
        create_parent_request if params[:status] == "approval"
        rejected_request if params[:status] == "rejected"
        flash_success
      rescue ActiveRecord::RecordInvalid
        flash_fault
      end
    else
      flash[:success] = "Chỉ sử lyd trạng thái chờ"
      redirect_to approval_request_path
    end
  end

  private

  def rejected_request
    @approval_request.personal_request.update!(status: "rejected")
    @approval_request.personal_request.notifications.create!(title: "Yêu cầu đã bị từ chối", sender_id: current_user.id, receiver_id: @approval_request.personal_request.user_id, status: "rejected")
  end

  def create_parent_request
    if current_user.manager? && !current_division.is_project?
      @send_request = Division.where(is_project: true).first.approval_requests.create!(personal_request_id: @approval_request.personal_request_id, send_for: 1)
      forwarded_request_user
      send_notifi_manager @send_request
    elsif current_division.is_project? && current_user.manager?
      @approval_request.personal_request.update!(status: "approval")
      send_notifi_user @approval_request
    elsif current_division.is_project? && current_user.member?
      @approval_request.personal_request.update!(status: "approval")
      send_notifi_user @approval_request
    else
      flash[:error] = "Bạn không có quền phê duyệt"
      redirect_to root_path
    end
  end

  def forwarded_request_user
    @approval_request.personal_request.update!(status: "forwarded")
  end

  def send_notifi_manager user_request
    current_user.projects.each do |project|
      user_request.notifications.create!(title: "Bạn có một yêu cầu được chuyển tiếp", sender_id: current_user.id, receiver_id: project.users.first.id)
    end
  end

  def send_notifi_user user_request
    user_request.personal_request.notifications.create!(title: "Yêu cầu đã được chấp nhận", sender_id: current_user.id, receiver_id: user_request.personal_request.user_id, status: "approval")
  end

  def flash_success
    flash[:success] = "Phê duyệt của bạn đã được cập nhật"
    redirect_to approval_requests_path
  end

  def flash_fault
    flash[:error] = "Phê duyệt của bạn cập nhật lỗi"
    redirect_to errors_path
  end

end
