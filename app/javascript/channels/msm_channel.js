import consumer from "./consumer"

$(document).on('turbolinks:load', function () {


  let messages = $('#messages')
  // console.log(messages.data('chat-room-id'))

  $('[data-channel-subscribe="room"]').each(function(index, element){
    var  $element = $(element)
    var  room_id = $element.data('chat-room-id')

    consumer.subscriptions.create({ channel: "MsmChannel", chat_room_id: room_id}, {
      connected() {
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log(data)
              // onPush(data);
       if (Notification.permission === 'granted') {
          var title = data.name_user
          var body = data.message.content
          var icon = "http://cdn.sstatic.net/stackexchange/img/logos/so/so-icon.png"
          var options = { body: body , icon: icon}
          notification = new Notification(title, options)

          notification.onclick = function () {
            window.open("http://google.com");
          };
          setTimeout(function(){
            notification.close(); // xác định thời gian noti sẽ biến mất sau khi hiện lên tính bằng ms
          },4000);

        }else {
          Notification.requestPermission();
        }
      }

    });
  });
});
