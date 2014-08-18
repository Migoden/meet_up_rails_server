class EventsController < ApplicationController
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
           events: current_user.events.as_json(:except => [:authentication_token])
        }
  end

  def create
     event = Event.create(params.permit(:name, :description, :start_time, :latitute, :longitude, :address))
     friend_array = []
     
     params[:friends].each do |friend_id|
      friend = User.find(friend_id)
      if(friend) 
        friend_array.push(friend)
      else
         render :status => 400,
         :json => { success: false,
           friend_id_not_found: friend_id}
      end
    end
     event.users = friend_array

     if (event.save)
     render :status => 200,
         :json => { success: true,
           events: event.as_json
        }
     else
         render :status => 400,
         :json => { success: false,
          error: event.errors}
        
     end
  end

  def show

  end
end
