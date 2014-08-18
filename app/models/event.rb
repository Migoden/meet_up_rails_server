class Event < ActiveRecord::Base
  has_many :event_user
  has_many :users, :through => :event_user
  validates :users, :presence => true
end
