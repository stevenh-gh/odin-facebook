class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.make_friendship(user_id, friend_id)
    user_friendship = Friendship.new(user_id: user_id, friend_id: friend_id)
    reverse = Friendship.new(user_id: friend_id, friend_id: user_id)
    [user_friendship, reverse]
  end

  def self.delete_friendship(user_id, friend_id)
    friendship_ids = [Friendship.where(user_id: user_id, friend_id: friend_id).first.id,
                      Friendship.where(user_id: friend_id, friend_id: user_id).first.id]
    Friendship.destroy(friendship_ids)
  end
end
