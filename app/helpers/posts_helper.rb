module PostsHelper

  def page_title
    if params[:action] == 'show'
      @post.title
    else
      super
    end
  end

  def sanitized_text(text, title)
    text = sanitize(text, tags: %w(b i u span img strong a), attributes: %w(href id class style src align)).gsub(/\n/, '<br />')
    text = fix_images(text, title)
    fix_links text
  end

  private
  def fix_links text
    text.gsub(/href=('|")(?!\/)([^\'\"]+)('|")/) do
      "href='/r/#{convert_url($2)}' target='_blank' rel='nofollow'"
    end
  end

  def fix_images(text, title)
    text.gsub!('http://i.imgur.com/', '/i/')
    title.gsub!("'", '"')
    text.gsub(/\<img .+?\>/) do |img|
      alts = ''
      alts += "alt='#{title}' " unless img.index('alt=')
      alts += "title='#{title}' " unless img.index('title=')
      img.gsub('<img ', "<img #{alts}")
    end
  end

end