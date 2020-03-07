import consumer from "./consumer"
$(document).on('turbolinks:load', function () {


  let messages = $('#messages')
  // console.log(messages.data('chat-room-id'))

  $('[data-channel-subscribe="room"]').each(function(index, element){
    var  $element = $(element)
    var  room_id = $element.data('chat-room-id')
    console.log($element)
    $element.animate({ scrollTop: $element.prop("scrollHeight")}, 1000)

        // console.log(messageTemplate)


    consumer.subscriptions.create({ channel: "RoomChannel", chat_room_id: room_id}, {
      connected() {
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // console.log(data.message)
        // console.log(data.layout)
        // let content = messageTemplate.children().clone(true, true);
        // // content.find('[data-role="user-avatar"]').attr('src', data.user_avatar_url);
        // content.find('[data-role="message-text"]').text(data.message);
        // // content.find('[data-role="message-date"]').text(data.updated_at);
        $element.append(data.layout);
        console.log($element.prop("scrollHeight"))
        $element.animate({scrollTop: $element.prop("scrollHeight")}, 1000);
      }
    });

  });
});
