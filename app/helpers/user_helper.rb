module UserHelper

  def page_title
    if params[:action] == 'show'
      "#{I18n.t('user')} #{@user.name}"
    else
      super
    end
  end

end