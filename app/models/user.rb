class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  validates(:name, presence: true)

  has_many(:posts)
  has_many(:comments)
  has_many(:likes)
  has_one(:profile)

  has_many(:friendships)
  has_many(:friends, through: :friendships)

  has_many(:sent_friend_requests, foreign_key: 'sender_id', class_name: 'FriendRequest')
  has_many(:friend_requests, foreign_key: 'receiver_id')

  before_create(:build_profile)
  after_create(:send_welcome_email)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # user.profile.photo = auth.info.image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def passthru
    super
  end

  private

  def build_profile_before_create
    build_profile
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_later
  end
end
