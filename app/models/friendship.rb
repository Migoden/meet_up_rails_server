class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :requested_friend, class_name: 'User'
	validates :user, :uniqueness => {:scope => :requested_friend}
	
end
