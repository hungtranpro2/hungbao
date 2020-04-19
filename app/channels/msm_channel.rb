class MsmChannel < ApplicationCable::Channel
  def subscribed
    # 5.times.each{|e,i| stream_from "room_sms#{e}"}
    # current_user.list_messages.uniq.each do |e|
    #   if e.id != params['chat_room_id']
    #     stream_from "room_sms#{e.id}"
    #   end
    # end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
