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

  def page_title
    trans_title = I18n.t("page_title.#{params[:controller]}.#{params[:action]}", default: I18n.t('page_title.default'))
    "TutorBear: #{trans_title}"
  end

end
