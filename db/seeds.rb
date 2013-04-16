#encoding: utf-8

langs = {
  en:
    ['English', 'Russian', 'German', 'Spanish', 'French',
     'Italian', 'Mandarin Chinese', 'Portuguese'],
  ru:
    ['Английский', 'Русский', 'Немецкий', 'Испанский', 'Французский',
    'Итальянский', 'Китайский', 'Португальский'] 
}

langs.each do |locale, langs|
  I18n.locale = locale
  Language.destroy_all
  Language.create(langs.uniq.map{|lang| {name: lang}})
end

