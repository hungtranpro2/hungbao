class MessageNotificationsController < ApplicationController
  def index
    @messages = Message.where(list_message: current_user.list_messages.uniq).where.not(user_id: current_user).order(created_at: :desc).limit(15)
  end

  respond_to do |format|
    format.html
    format.js
  end
end
