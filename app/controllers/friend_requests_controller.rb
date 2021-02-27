class FriendRequestsController < ApplicationController
  def index
    @friend_requests = current_user.friend_requests
  end
end
