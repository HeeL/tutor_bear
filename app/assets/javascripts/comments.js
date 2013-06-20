$(document).ready(function(){
  track_remote_messages($('.reply-form'));
  
  $('.cmt-reply').on('click', function(e){
    $(e.target).parent().find('form').fadeIn();
    $(e.target).hide();
  });

  $('.reply-form').live('ajax:success', function(data, response, xhr) {
    if (response.status != 'error') {
      $(data.target).hide();
    }
  });

});