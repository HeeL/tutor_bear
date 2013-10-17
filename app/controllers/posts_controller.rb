class PostsController < ApplicationController

  before_filter :check_spam, only: :add_cmt


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

  def check_spam
    delay = params[:text].to_s.match(/(http|www)/) ? 30 : 15
    params[:text] = '' if Time.now.to_i - params[:i].to_i < delay
  end

  def save_and_render_result
    if !@cmt.save
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
