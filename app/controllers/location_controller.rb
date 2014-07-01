class LocationController < ApplicationController
  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!

  # This is Devise's authentication
  before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token,
                :if => Proc.new { |c| c.request.format == 'application/json' }


  respond_to :json

  def index
    str = '{
    "success":true,
    "info":"ok",
    "data":{
            "tasks":[
                      {"title":"Complete the app"},
                      {"title":"Complete the tutorial"}
                    ]
           }
  }'

  # str = str + "current user: #{authenticate_user!.email}"
    render :text => str
  end

  private
  
  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)
 
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end
end
