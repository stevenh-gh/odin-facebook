class Post < ApplicationRecord
  validates(:title, presence: true)
  validates(:text, presence: true)
  belongs_to(:user)
  has_many(:comments)
  has_many(:likes)
end
