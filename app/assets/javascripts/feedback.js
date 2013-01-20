$(document).ready(function(){

  $('#feedback_link').bind('click', function(){

    $('#feedback_form').css('right', '80px');
    $('#feedback_form').css('top', $('#feedback_link').offset().top - 280 + 'px');
    $('#feedback_form').toggle('slide');
  });

  track_remote_messages($('#feedback_form'));

  $('#feedback_form').bind('ajax:success', function(data, response, xhr) {
    if (response.status == 'success') {
      $('#feedback_form #text').val('');
      $(this).hide('slide');
    }
  });

});