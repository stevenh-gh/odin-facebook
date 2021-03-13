class PostsController < ApplicationController
  before_action(:authenticate_user!)

  def index
    # @posts = User.where(id: params[:user_id]).last.posts
    user = User.find(params[:user_id])
    # @posts = (Post.where(user_id: user.id) +
    #           user.friends.inject([]) { |acc, friend| acc + Post.where(user_id: friend.id) })
    #          .sort_by { |post| post.created_at }.reverse!
    # query = <<~SQL
    #   SELECT *
    #   FROM posts

    #   INNER JOIN friendships
    #   ON friendships.friend_id = posts.user_id

    #   INNER JOIN users
    #   ON users.id = posts.user_id OR users.id = friendships.user_id

    #   WHERE users.id = #{user.id}
    #   ORDER BY posts.created_at DESC
    # SQL

    # @posts = ActiveRecord::Base.connection.exec_query(query).to_a
    @posts = Post.joins('INNER JOIN friendships ON friendships.friend_id = posts.user_id')
                 .joins('INNER JOIN users ON users.id = posts.user_id OR users.id = friendships.user_id')
                 .where('users.id = ?', user.id).order(created_at: :desc)
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
    @comment = Comment.new
    @comments = Comment.where(user_id: current_user.id, post_id: @post.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :user_id)
  end
end
