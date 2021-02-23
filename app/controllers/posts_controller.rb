class PostsController < ApplicationController
  before_action(:authenticate_user!)

  def index
    @posts = User.where(id: params[:user_id]).last.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to(user_posts_path)
    else
      flash.now[:error] = @post.errors.full_messages
      render(:new)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :user_id)
  end
end
