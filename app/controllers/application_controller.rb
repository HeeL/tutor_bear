class ApplicationController < ActionController::Base
  protect_from_forgery

  def set_success(text = '')
    {status: 'success', text: text}
  end

  def set_error(text)
    {status: 'error', text: text}
  end

  def md5(string)
    Digest::MD5.hexdigest(string)
  end

end
