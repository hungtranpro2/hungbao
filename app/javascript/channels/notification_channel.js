import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data.layout)
    $("#notification-list").prepend(data.layout)
    $("#notification-counter").html(data.counter)
    if (Notification.permission === 'granted') {
      var title = data.notifi.title +""
      var body = "Notification form " + data.name_sender
      var options = { body: body }
      notification = new Notification(title, options)
      setTimeout(function(){
          notification.close(); // xác định thời gian noti sẽ biến mất sau khi hiện lên tính bằng ms
        },4000);
    }else {
      Notification.requestPermission();
    }
  }
});
