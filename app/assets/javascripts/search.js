$(document).ready(function(){

  $('#langs').tagit({
    allowSpaces: true,
    caseSensitive: false,
    autocomplete: {
      source: function( request, response ) {
        $.get('/' + current_lang + '/languages/match_names', {name: request.term}, function(data){
          response(data);
        });
      },
      minLength: 2
    },
    afterTagAdded: function(event, input) {
      lang = input.tag.find('span.tagit-label').text();
      $.get('/' + current_lang + '/languages/match_names', {name: lang, exact: 1}, function(data){
        if(data.length == 0) {
          show_message(I18n.t('no_lang', {lang: lang}), '', 'error');
          $(event.target).tagit('removeTagByLabel', lang);
        }
      });
    }
  });

  $('#who_teacher, #who_learner').bind('change', function(){
    current_label = $('#submit_search').val();
    if($('input[name="who"]:checked').val() == 'teacher') {
      new_label = current_label.replace(I18n.t('learners_show'), I18n.t('teachers_show'));
      $('#who_header').html(I18n.t('teacher_title'));
      $('#who_no_price').html(I18n.t('teachers_no_price'));
      $('#who_styles').removeClass('learn');
      $('#who_styles').addClass('teach');
    }
    else {
      new_label = current_label.replace(I18n.t('teachers_show'), I18n.t('learners_show'));
      $('#who_header').html(I18n.t('learner_title'));
      $('#who_no_price').html(I18n.t('learners_no_price'));
      $('#who_styles').removeClass('teach');
      $('#who_styles').addClass('learn');
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
    $.post('/' + current_lang + '/search/get_count', $('#search_form').serialize(), function(data) {
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
    results_on_page = $('.contact').length;
    if ($('#result_count').val() > results_on_page && response != '') {
      $('#offset').val(results_on_page)
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