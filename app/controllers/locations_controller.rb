class LocationsController < ApplicationController
  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!

  # This is Devise's authentication
  before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token,
                :if => Proc.new { |c| c.request.format == 'application/json' }


  respond_to :json

  def index
       render :status => 200,
         :json => { success: true,
                     locations: Location.all.as_json}
  
  end

  def create
    locations = []
     params[:locations].each do |locationJSON|
       locationJSON[:recorded_at] = Time.at(locationJSON[:recorded_at]).to_datetime.strftime("%Y-%m-%d")
       location = Location.create(locationJSON.permit(:recorded_at, :latitude, :longitude))
       location.user = User.find(locationJSON[:user_id])
       
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

         render :status => 200,
           :json => { success: true,
                       locations: locations.as_json}


  end

  def show

  end
end
