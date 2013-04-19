$(document).ready(function(){

  $('.contact-send').live('click', function(e) {
    send_to    = $(e.target).attr('data-send-to');
    receive_as = $(e.target).attr('data-receive-as');
    link = $(e.target);
    loading = link.parent().find('.loading');
    loading.show();
    $.post('/'+current_lang+'/send_contacts', {send_to: send_to, receive_as: receive_as}, function(data, e) {
      if (data.status == 'error') {
        show_message(data.text, I18n.t('error'), 'error');
      }
      else {
        show_message(data.text, 'Ok');
        link.addClass('gray-send');
      }
    }).error(function(data) { 
      show_message(I18n.t('status') + ': ' + data.status + '\n' + data.statusText, I18n.t('error'), 'error'); 
    }).complete(function() {
      loading.hide();
    });
  });
});