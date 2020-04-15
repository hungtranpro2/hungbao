import consumer from "./consumer"
$(document).on('turbolinks:load', function () {


  let messages = $('#messages')
  // console.log(messages.data('chat-room-id'))

  $('[data-channel-subscribe="room"]').each(function(index, element){
    var  $element = $(element)
    var  room_id = $element.data('chat-room-id')
    consumer.subscriptions.create({ channel: "RoomChannel", chat_room_id: room_id}, {
      connected() {
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {

        $element.prepend(data.layout)
      }
    });
  });
});
