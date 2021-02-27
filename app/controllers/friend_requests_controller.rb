class FriendRequestsController < ApplicationController
  before_action(:validate_friend_request, only: :create)

  def index
    @friend_requests = current_user.friend_requests
  end

  def create
    @friend_request = FriendRequest.new(sender_id: params[:sender_id],
                                        receiver_id: params[:receiver_id])
    if @friend_request.save
      flash_with_redirect(:success, "Friend request has been sent to #{User.find(params[:receiver_id]).name}", root_path)
    else
      flash_with_redirect(:error, @friend_request.errors.full_messages, root_path)
    end
  end

  def destroy
    FriendRequest.find(params[:id]).destroy
    redirect_to(root_path)
  end

  private

  def flash_with_redirect(symbol, msg, link)
    flash[symbol] = msg
    redirect_to(link)
  end

  def validate_friend_request
    if params[:sender_id].eql?(params[:receiver_id])
      flash_with_redirect(:error, 'You cannot add yourself as friend!', root_path)
    elsif FriendRequest.exists?(sender_id: params[:sender_id],
                                receiver_id: params[:receiver_id])
      flash_with_redirect(:error, 'Request already exists!', root_path)
    end
  end
end
