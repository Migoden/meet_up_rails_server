class Location < ActiveRecord::Base
  belongs_to :user

  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates :user_id, :presence => true

  def as_json(options={})
    	 json = super(:recorded_at => self.recorded_at.to_time.to_i)
    	 json['recorded_at'] = self.recorded_at.to_time.to_i
    	 json
  end
end
