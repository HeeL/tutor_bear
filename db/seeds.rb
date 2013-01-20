langs = ['English', 'Russian', 'German', 'Spanish', 'French', 'Italian', 'Mandarin Chinese', 'Portuguese']

Language.create(langs.uniq.map{|lang| {name: lang}})

