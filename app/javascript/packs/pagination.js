$(document).on('turbolinks:load', function () {
    isScroll = false;
  $("#message").on('scroll', function(){
    var more_posts_url = $('.pagination a:last').attr('href');
    var scroll = $("#message").scrollTop();
    var height = $("#message").prop('scrollHeight') - $("#message").height() - 30;

    if (more_posts_url  != undefined && scroll > height && isScroll == false) {
      $('#loading').css("display","block");
        setTimeout(function() {
          $('#loading').css("display","none");
        }, 2000);
      $.getScript(more_posts_url);
      isScroll = true;
    }else{
      if (scroll < $("#message").prop('scrollHeight') - $("#message").height() - 30){
        isScroll = false;
      }
    }
  });
});
