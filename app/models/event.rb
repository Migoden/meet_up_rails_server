class Event < ActiveRecord::Base
  has_many :event_user
  has_many :users, :through => :event_user
  validates :users, :presence => true

  def as_json(options={})
    	 json = super(:start_time => self.start_time.to_time.to_i)
    	 json['start_time'] = self.start_time.to_time.to_i
    	 json
  end

  scope :with_participant, lambda { |user| 
            includes(:producer).where('users.id LIKE ?', "%#{user.id}%") 
  }
end
