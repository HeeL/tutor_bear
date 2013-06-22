$(document).ready(function(){
  track_remote_messages($('.reply-form'));
  
  $('.cmt-reply').on('click', function(e){
    $(e.target).parent().find('form').fadeIn();
    $(e.target).hide();
  });

  $('.cmt-add').on('click', function(e){
    $('form[data-cmt-id="0"]').fadeIn();
    $(e.target).hide();
  });

  $('.reply-form').live('ajax:success', function(data, response, xhr) {
    if (response.status != 'error') {
      $(this).hide();
      cmt_id = $(this).attr('data-cmt-id');
      reply_block = $('div[data-reply-to="'+ cmt_id +'"]')
      reply_block.find('b').text($(this).find('#name').val());
      reply_block.find('.text').text($(this).find('textarea').val());
      reply_block.show();
    }
  });

});