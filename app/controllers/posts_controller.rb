class PostsController < ApplicationController

  def index
    @posts = Post.published
  end

  def show
    @post = Post.where(id: params[:id])
    @post = current_admin_user ? @post.first : @post.published.first
    redirect_to posts_path unless @post
  end

end
