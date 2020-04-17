class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast build_room_id(message.list_message_id), message: message, layout: render_message(message)
    # ActionCable.server.broadcast build_room_sms_id(message.list_message_id), message: message, name_user: message.user.name
  end

  def build_room_id(id)
    "chat_rooms_#{id}_channel"
  end

  # def build_room_sms_id(id)
  #   "room_sms#{id}"
  # end

  def render_message message
    ApplicationController.renderer.render(partial: "room_chats/message", locals: {message: message})
  end
end
