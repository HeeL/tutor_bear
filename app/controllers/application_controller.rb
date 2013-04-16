class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def set_success(text = '')
    {status: 'success', text: text}
  end

  def set_error(text)
    {status: 'error', text: text}
  end

  def md5(string)
    Digest::MD5.hexdigest(string)
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  private
  def set_locale
    if TutorBear::Application::LANGS.include?(params[:locale].try(:to_sym))
      session[:current_lang] = I18n.locale = params[:locale]
    elsif session[:current_lang].present?
      I18n.locale = session[:current_lang] 
    end
  end

end
