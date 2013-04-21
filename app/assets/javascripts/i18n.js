I18n = {
  dict: {
    en: {
      error: 'Error',
      status: 'Status',
      no_lang: "We don't have '%lang%' in our list",
      learners_no_price: 'learners',
      teachers_no_price: 'teachers',
      learners_show: 'Learners',
      teachers_show: 'Teachers',
      teacher_title: 'Teachers',
      learner_title: 'Learners'
    },
    ru: {
      error: 'Ошибка',
      status: 'Статус',
      no_lang: "Мы не нашли '%lang%' в списке языков",
      learners_no_price: 'учеников',
      teachers_no_price: 'учителей',
      learners_show: 'Учиников',
      teachers_show: 'Учителей',
      teacher_title: 'Учителя',
      learner_title: 'Ученики'
    }
  },

  t: function(key, vars){
    trans = this.dict[current_lang][key]
    if (trans) {
      if(!vars){
        return trans;
      }
      $.each(vars, function(k,v){
        trans = trans.replace('%'+ k +'%', v);
      });
      return trans;
    }
    else{
      return key;
    }
  }
}