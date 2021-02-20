class PostsController < ApplicationController
  def index
    @posts = User.where(id: params[:user_id]).last.posts
  end
end
