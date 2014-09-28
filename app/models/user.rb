class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # You likely have this before callback set up for the token.
  before_save :ensure_authentication_token
 
  has_many :friendships
  has_many :requested_friends, through: :friendships

  # has_many :friends, class_name: 'User'
  
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'requested_friend_id'
  has_many :inverse_requested_friends, through: :inverse_friendships, source: :user

  has_many :event_user
  has_many :events, :through => :event_user
  
  has_many :locations

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
 
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end


end
