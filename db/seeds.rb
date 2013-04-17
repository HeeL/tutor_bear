#encoding: utf-8

LANGS = {
  en:
    ['English', 'Russian', 'German', 'Spanish', 'French',
     'Italian', 'Mandarin Chinese', 'Portuguese'],
  ru:
    ['Английский', 'Русский', 'Немецкий', 'Испанский', 'Французский',
    'Итальянский', 'Китайский', 'Португальский']
}.freeze

def reset_autoincrement
  ActiveRecord::Base.connection.exec_query("ALTER SEQUENCE languages_id_seq RESTART WITH 9;")
end

def update_lang(lang, i)
  LANGS.keys[1..-1].each do |locale|
    I18n.locale = locale
    lang.update_attributes(name: LANGS[locale][i])
  end
end

Language.destroy_all
reset_autoincrement

LANGS[I18n.default_locale].each_with_index do |name, i|
  update_lang(Language.create(name: name, locale: I18n.default_locale), i)
end
