$(document).ready(function(){

  $('#langs').tagit({
    allowSpaces: true,
    autocomplete: {
      source: function( request, response ) {
        $.get('/languages/match_names', {name: request.term}, function(data){
          response(data);
        });
      },
      minLength: 2
    },
    afterTagAdded: function(event, input) {
      lang = input.tag.find('span.tagit-label').text();
      $.get('/languages/match_names', {name: lang, exact: 1}, function(data){
        if(data.length == 0) {
          show_message("We don't have \"" + lang + "\" in our list", '', 'error')
          $(event.target).tagit('removeTagByLabel', lang);
        }
      });
    }
  });

  $('#who_teacher, #who_learner').bind('change', function(){
    current_label = $('#submit_search').val()
    if($('input[name="who"]:checked').val() == 'teacher') {
      new_label = current_label.replace('Learners', 'Teachers')
    }
    else {
      new_label = current_label.replace('Teachers', 'Learners')
    }
    $('#submit_search').val(new_label)
  });

  function clean_results() {
    $('#search_results').html('');
    $('#show_more').hide();
    $('#offset').val(0);  
  }

  $('#submit_search').bind('click', function() {
    clean_results();
  });

  $('#search_form input').bind('change keyup', function() {
    clean_results();
  });

  $('#search_form input').bind('change', function() {
    update_result_count();
  });

  $('#price').bind('keyup', function() {
    update_result_count();
  });

  function update_result_count() {
    $.post('/search/get_count', $('#search_form').serialize(), function(data) {
      label = $('#submit_search').val();
      $('#submit_search').val(label.replace(label.slice(label.indexOf(' (') + 2), data + ')'));
      $('#result_count').val(data);
    });
  }

  $('#who_teacher').change();

  $('#search_form').bind('ajax:success', function(data, response, xhr) {
    if(response != '') {
      $('#search_results').append(response);
    }
    else {
      update_result_count();
    }
    if ($('#result_count').val() > $('.person').length && response != '') {
      $('#offset').val($('.person').length)
      $('#show_more').show();
    }
    else {
      $('#show_more').hide();
    }
  });

  $('#show_more').bind('click', function() {
    $('#search_form').submit()
  });

});