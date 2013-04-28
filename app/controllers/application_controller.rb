class ApplicationController < ActionController::Base
  protect_from_forgery
  clear_helpers

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  before_filter :set_locale

  helper_method :user_signed_in?, :current_user, :admin_user_signed_in?, :current_admin_user

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

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
