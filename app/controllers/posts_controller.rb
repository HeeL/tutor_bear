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
    @cmt = Comment.new(
      commentable: Post.find(params[:post_id]),
      name: params[:name],
      text: params[:text],
      locale: I18n.locale
    )
    set_cmt_parent
    save_and_render_result
  end

  def delete_cmt
    Comment.destroy(params[:id]) if admin_user_signed_in?
  end

  private

  def save_and_render_result
    if true || !@cmt.save
      @cmt.errors.add(:base, 'Today we are closed. Please try again tomorrow.')
      result = set_error(@cmt.errors.full_messages.first)
    else
      result = set_success
    end
    render json: result
  end

  def set_cmt_parent
    @cmt.parent_id = params[:cmt_id] if params[:cmt_id].present?
  end
end
