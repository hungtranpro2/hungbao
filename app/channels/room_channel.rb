class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # def speak(data)
  #   sender    = get_sender(data)
  #   room_id   = data['room_id']
  #   message   = data['message']

  #   raise 'No room_id!' if room_id.blank?
  #   convo = get_convo(room_id) # A conversation is a room
  #   raise 'No conversation found!' if convo.blank?
  #   raise 'No message!' if message.blank?

  #   # adds the message sender to the conversation if not already included
  #   convo.users << sender unless convo.users.include?(sender)
  #   # saves the message and its data to the DB
  #   # Note: this does not broadcast to the clients yet!
  #   Message.create!(
  #     conversation: convo,
  #     sender: sender,
  #     content: message
  #   )
  # end

  # # Helpers

  # def get_convo(room_code)
  #   Conversation.find_by(room_code: room_code)
  # end

  # def set_sender
  #   User.find_by(guid: id)
  # end
end
