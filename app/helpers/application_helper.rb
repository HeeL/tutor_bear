module ApplicationHelper

  def js_msg(text_arr, type = '')
    js = text_arr.map{|text| "show_message(\"#{text.gsub(/"/, "'")}\"#{', "", "error"' if type == 'error'});" if text.present?}.reject{|i| i.nil?}
    javascript_tag("$(document).ready(function(){ #{js.join} });") unless js.empty?
  end

  def on_root_page?
    request.fullpath == '/'
  end

  def all_langs
    TutorBear::Application::LANGS
  end

  def show_flags
    links = ''
    all_langs.each do |lang|
      links += link_to(image_tag("#{lang}.png", alt: I18n.t(lang), title: I18n.t(lang)), url_for(locale: lang))
    end
    links
  end

  def page_title
    trans_title = I18n.t("page_title.#{params[:controller]}.#{params[:action]}", default: I18n.t('page_title.default'))
    "TutorBear: #{trans_title}"
  end

  def convert_url(url)
    Rack::Utils.escape(url).gsub('.', '1____1')
  end

  def revert_url(url)
    Rack::Utils.unescape(url).gsub('1____1', '.')
  end


end
