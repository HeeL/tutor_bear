I18n = {
  dict: {
    en: {
      error: 'Error',
      status: 'Status',
      no_lang: "We don't have '%lang%' in our list"
    },
    ru: {
      error: 'Ошибка',
      status: 'Статус',
      no_lang: "Мы не нашли '%lang%' в списке языков"
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