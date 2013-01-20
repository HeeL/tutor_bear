function show_message(text, title, type){
  if(typeof(title)==='undefined') title = '';
  if(typeof(type)==='undefined') type = '';

  $.pnotify( {type: type, title: title, text: text} );
}

function track_remote_messages(el){
  el.bind('ajax:error', function(data, status, xhr) {
    show_message('Status: ' + status.status + '\n' + status.statusText, 'Error', 'error');
  });
  el.bind('ajax:success', function(data, response, xhr) {
    if (response.status == 'error') {
      show_message(response.text, 'Error', 'error');
    }
    else {
      show_message(response.text, 'Success');
    }
  });
}

function show_hide(el, show) {
  show ? el.fadeIn() : el.fadeOut()
}

$(document).ready(function(){
  $('form[data-remote=true]').bind('ajax:send', function(){
    $(this).find('.loading').show('slow');
    $(this).find('input[type="submit"]').attr('disabled', true)
  });
  $('form[data-remote=true]').bind('ajax:complete', function(){
    $(this).find('.loading').hide();
    $(this).find('input[type="submit"]').attr('disabled', false)
  });

  $('#sign_up_link').bind('click', function(){
    $('#sign_in_block').hide();
    $('#sign_up_block').toggle('inline');
  });
  $('#sign_in_link').bind('click', function(){
    $('#sign_up_block').hide();
    $('#sign_in_block').toggle('inline');
  });
});
