module PostsHelper

  def sanitized_text(text)
    sanitize(text, tags: %w(b i u span img strong), attributes: %w(id class style)).gsub(/\n/, '<br />')
  end

  def page_title
    if params[:action] == 'show'
      @post.title
    else
      super
    end
  end

end