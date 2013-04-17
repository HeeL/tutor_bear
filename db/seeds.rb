#encoding: utf-8

langs = {
  en:
    ['English', 'Russian', 'German', 'Spanish', 'French',
     'Italian', 'Mandarin Chinese', 'Portuguese'],
  ru:
    ['Английский', 'Русский', 'Немецкий', 'Испанский', 'Французский',
    'Итальянский', 'Китайский', 'Португальский'] 
}

def reset_autoincrement
  ActiveRecord::Base.connection.exec_query("ALTER SEQUENCE languages_id_seq RESTART WITH 9;")
end

Language.destroy_all
reset_autoincrement

langs[:en].each do |locale, langs|
  #Language.create(name: )
  #I18n.locale = :ru
  #update
end
