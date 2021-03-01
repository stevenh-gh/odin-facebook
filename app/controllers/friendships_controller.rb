class FriendshipsController < ApplicationController
  def create
    friendships = Friendship.make_friendship(current_user.id, params[:friend_id])
    if friendships[0].save && friendships[1].save
      flash[:success] = "#{User.find(params[:friend_id]).name} has been added as friend."
      FriendRequest.destroy(FriendRequest.where(sender_id: params[:friend_id], receiver_id: current_user.id).first.id)
      redirect_to(root_path)
    else
      flash[:error] = friendships[0].errors.full_path
      redirect_to(root_path)
    end
  end

  def destroy; end
end
