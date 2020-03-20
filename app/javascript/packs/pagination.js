$(document).on('turbolinks:load', function () {
  var isFetching = false;
  $("#message").on('scroll', function(){
    var more_posts_url = $('.pagination a:last').attr('href');
    var scroll = $("#message").scrollTop();
    if (scroll  <  1 && isFetching == false) {
      // $('#loading').css('display', 'block');
      setTimeout(function() {
        $("#message").animate({scrollTop: $("#message").height()}, 500);
      }, 2000);

      isFetching = true;
      $.getScript(more_posts_url);
    }else{
      // $('#loading').css('display', 'none');
      isFetching = false;
    }
  });
});
