class EventController < ApplicationController
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
     event = Event.create(params)
     if (event)
     render :status => 200,
         :json => { success: true,
           events: event.as_json
        }
      end
    else
         render :status => 400,
         :json => { success: false}
        }
    end
  end

  def show

  end
end
