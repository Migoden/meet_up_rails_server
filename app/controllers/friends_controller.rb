class FriendsController < ApplicationController
  before_filter :authenticate_user_from_token!

  before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token,
                :if => Proc.new { |c| c.request.format == 'application/json' }


  respond_to :json

  def index 
    contact_numbers = params['contact_numbers']

    found_users = []
    contact_numbers.each do |phone_number| 
      user = User.find_by phone_number: phone_number
      if user
        found_users << user 
      end
    end

  	render :status => 200,
  		   :json => { success: true,
          users: found_users.as_json(:except => [:authentication_token])}

  end
end