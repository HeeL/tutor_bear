$(document).ready(function(){

  $('.contact-send').live('click', function(e) {
    send_to    = $(e.target).attr('data-send-to');
    receive_as = $(e.target).attr('data-receive-as');
    link = $(e.target);
    loading = link.parent().find('.loading');
    loading.show();
    $.post('/send_contacts', {send_to: send_to, receive_as: receive_as}, function(data, e) {
      if (data.status == 'error') {
        show_message(data.text, 'Error', 'error');
      }
      else {
        show_message(data.text, 'Success');
        link.hide();
      }
    }).error(function(data) { 
      show_message('Status: ' + data.status + '\n' + data.statusText, 'Error', 'error'); 
    }).complete(function() {
      loading.hide();
    });
  });
});