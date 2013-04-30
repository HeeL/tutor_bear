module PostsHelper

  def sanitized_text(text)
    text = sanitize(text, tags: %w(b i u span img strong a), attributes: %w(href id class style src align)).gsub(/\n/, '<br />')
    text = fix_images text
    fix_links text
  end

  def page_title
    if params[:action] == 'show'
      @post.title
    else
      super
    end
  end

  private
  def fix_links text
    text.gsub(/href=('|")(?!\/)([^\'\"]+)('|")/) do
      "href='/r/#{convert_url($2)}' target='_blank' rel='nofollow'"
    end
  end

  def fix_images text
    text.gsub('http://i.imgur.com/', '/i/')
  end

end