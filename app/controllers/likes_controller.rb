class LikesController < ApplicationController
  before_action(:check_liked, only: :create)

  def create
    @like = current_user.likes.build(post_id: params[:post_id])
    if @like.save
      redirect_back(fallback_location: root_path)
    else
      redirect_to(root_path)
    end
  end

  def destroy
    Like.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def check_liked
    if current_user.likes.exists?(post_id: params[:post_id])
      flash[:error] = 'You already liked this post!'
      redirect_back(fallback_location: root_path)
    end
  end
end
