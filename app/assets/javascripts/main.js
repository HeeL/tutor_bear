function show_message(text, title, type){
  if(typeof(title)==='undefined') title = '';
  if(typeof(type)==='undefined') type = '';

  $.pnotify( {type: type, title: title, text: text} );
}

function track_remote_messages(el){
  el.live('ajax:error', function(data, status, xhr) {
    show_message(I18n.t('status') + ': ' + status.status + '\n' + status.statusText, I18n.t('error'), 'error');
  });
  el.live('ajax:success', function(data, response, xhr) {
    if (response.status == 'error') {
      show_message(response.text, I18n.t('error'), 'error');
    }
    else {
      show_message(response.text, 'Ok');
    }
  });
}

function show_hide(el, show) {
  show ? el.fadeIn() : el.fadeOut()
}

$(document).ready(function(){
  current_lang = $('body').data('lang')

  $('#sign_in_link').popover({
    html: true,
    placement: 'bottom',
    title: $('#sign_in_block').html()
  });

  $('#sign_up_link').popover({
    html: true,
    placement: 'bottom',
    title: $('#sign_up_block').html()
  });

  $('#sign_in_link').bind('click', function() {
    $('#sign_up_link').popover('hide');
  });

  $('#sign_up_link').bind('click', function() {
    $('#sign_in_link').popover('hide');
  });

  $('form[data-remote=true]').live('ajax:send', function(){
    $(this).find('.loading').show('slow');
    $(this).find('input[type="submit"]').attr('disabled', true)
  });
  $('form[data-remote=true]').live('ajax:complete', function(){
    $(this).find('.loading').hide();
    $(this).find('input[type="submit"]').attr('disabled', false)
  });

});
