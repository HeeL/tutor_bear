module PostsHelper

  def page_title
    if params[:action] == 'show'
      @post.title
    else
      super
    end
  end

end