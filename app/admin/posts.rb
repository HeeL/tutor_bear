ActiveAdmin.register Post do

  index do
    column :title
    column :published_at
    column :preview do |p|
      link_to 'Preview', post_path(p), target: '_blank'
    end
    default_actions
  end
  
  form multipart: true do |f|
    f.inputs do
      f.input :title
      f.input :desc, as: :text, input_html: {rows: 6, cols: 20}
      f.input :text, as: :text, input_html: {rows: 14, cols: 20}
      f.input :published_at, as: :datepicker
    end

    f.buttons
  end

  sidebar :languages do
    sidebar = ''
    all_langs.each do |lang|
      sidebar += link_to(image_tag("#{lang}.png"), url_for(locale: lang))
      sidebar += '&nbsp;' * 5
    end
    sidebar.html_safe
  end
  
end
