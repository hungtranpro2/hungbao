import consumer from "./consumer"
$(document).on('turbolinks:load', function () {


  let messages = $('#messages')
  // console.log(messages.data('chat-room-id'))

  $('[data-channel-subscribe="room"]').each(function(index, element){
    var  $element = $(element)
    var  room_id = $element.data('chat-room-id')
    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)

    consumer.subscriptions.create({ channel: "RoomChannel", chat_room_id: room_id}, {
      connected() {
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {

        console.log(data.messages)

        $element.append(data.layout);
        $element.animate({scrollTop: $element.prop("scrollHeight")}, 1000);

      }

    });
  });
});
