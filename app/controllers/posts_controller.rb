class PostsController < ApplicationController
  before_action(:authenticate_user!)

  def index
    @posts = User.where(id: params[:user_id]).last.posts
  end
end
