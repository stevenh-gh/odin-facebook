class LikesController < ApplicationController
  def create
    @like=current_user.likes.build(post_id: params[:post_id])
    if @like.save
      redirect_back(fallback_location: root_path)
    else
      redirect_to(root_path)
    end
  end
end
