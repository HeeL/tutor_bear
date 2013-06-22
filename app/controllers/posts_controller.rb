class PostsController < ApplicationController

  def index
    @posts = Post.published
  end

  def show
    @post = Post.where(id: params[:id])
    @post = current_admin_user ? @post.first : @post.published.first
    redirect_to posts_path unless @post
  end

  def add_cmt
    cmt = Comment.new(
      commentable: Post.find(params[:post_id]),
      name: params[:name],
      text: params[:text]
    )
    cmt.parent_id = params[:cmt_id] if params[:cmt_id].present?

    if !cmt.save
      result = set_error(cmt.errors.full_messages.first)
    else
      result = set_success
    end
    render json: result
  end

end
