class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast build_room_id(message.list_message_id), message: message, layout: render_message(message)
  end

  def build_room_id(id)
    "chat_rooms_#{id}_channel"
  end

  def render_message message
    ApplicationController.renderer.render(partial: "room_chats/message", locals: {message: message})
  end
end
