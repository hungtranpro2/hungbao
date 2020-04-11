module StaticPagesHelper
  def current_division
    @current_division = current_user.division
  end

  def notification
    @notifications = current_user.notifications.order(created_at: :desc)
  end
end
