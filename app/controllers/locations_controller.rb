class LocationsController < ApplicationController
  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!

  # This is Devise's authentication
  before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token,
                :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def index
    if(params[:event_id]) 
        event = Event.find(params[:event_id])
        users = event.users
        locations = []
        users.each do |user|
          locations << user.locations
        end 
        render :status => 200,
           :json => { success: true,
                       locations: locations.as_json}
    else
        render :status => 400,
           :json => { success: false,
                       error: 'missing event_id'}
    end
  end

  def create
    locations = []
     params[:locations].each do |locationJSON|
       locationJSON[:recorded_at] = Time.at(locationJSON[:recorded_at]).to_datetime.strftime("%Y-%m-%d")
       location = Location.create(locationJSON.permit(:recorded_at, :latitude, :longitude))
       location.user = current_user
       
       if (location.save)
           locations.push location
       else
           render :status => 400,
           :json => { success: false,
            error: location.errors,
            successfullyAdded: locations.as_json}
           return
       end

     end

     # removeOldLocations(current_user)
     render :status => 200,
       :json => { success: true,
                   locations: locations.as_json}
  end

  def removeOldLocations (user)   
    if(user.locations.last.recorded_at < 1.week.ago)
      user.locations.where(:recorded_at < 1.week.ago).destroy_all
    end
  end

  def show

  end
end
