class LocationController < ApplicationController
  # This is our new function that comes before Devise's one
  # before_filter :authenticate_user_from_token!
  # This is Devise's authentication
  # before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token,
                :if => Proc.new { |c| c.request.format == 'application/json' }

 # Just skip the authentication for now
  # before_filter :authenticate_user!

  respond_to :json

  def index
    render :text => '{
	  "success":true,
	  "info":"ok",
	  "data":{
	          "tasks":[
	                    {"title":"Complete the app"},
	                    {"title":"Complete the tutorial"}
	                  ]
	         }
	}'
  end

end
