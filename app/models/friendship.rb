class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.make_friendship(user_id, friend_id)
    user_friendship = Friendship.new(user_id: user_id, friend_id: friend_id)
    reverse = Friendship.new(user_id: friend_id, friend_id: user_id)
    [user_friendship, reverse]
  end
end
