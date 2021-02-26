class FriendshipsController < ApplicationController
  def create
    # @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    # if @friendship.save
    #   flash[:success] = "#{User.find(params[:friend_id]).name} has been added as friend."
    #   redirect_to(root_path)
    # else
    #   flash[:error] = @friendship.errors.full_path
    #   redirect_to(root)
    # end
    friendships = Friendship.make_friendship(current_user.id, params[:friend_id])
    if friendships[0].save && friendships[1].save
      flash[:success] = "#{User.find(params[:friend_id]).name} has been added as friend."
      redirect_to(root_path)
    else
      flash[:error] = friendships[0].errors.full_path
      redirect_to(root_path)
    end
  end

  def destroy; end
end
