class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates(:name, presence: true)

  has_many(:posts)
  has_many(:comments)
  has_many(:likes)

  has_many(:friendships)
  has_many(:friends, through: :friendships)

  has_many(:sent_friend_requests, foreign_key: 'sender_id', class_name: 'FriendRequest')
  has_many(:friend_requests, foreign_key: 'receiver_id')
end
