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

  private

  def check_liked
    if Like.exists?(user_id: current_user.id)
      flash[:error] = 'You already liked this post!'
      redirect_back(fallback_location: root_path)
    end
  end
end
