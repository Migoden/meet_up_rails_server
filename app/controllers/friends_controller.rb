class FriendsController < ApplicationController
  before_filter :authenticate_user_from_token!

  before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token,
                :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def index 
    contact_numbers = params['contact_numbers']

    non_friend_users = []
    friends = []

    contact_numbers.each do |phone_number| 
      found_user = User.find(:all, conditions: ["phone_numbers like?", "%#{phone_number}%"]).first
      if found_user
            non_friend_users << found_user 
      end
    end

   # current_user.requested_friends.each do |requested_friend| 
   #    if (current_user.inverse_requested_friends.include?(requested_friend))
   #        friends << requested_friend
   #        non_friend_users.delete(requested_friend)
   #    end
   # end 

  	render :status => 200,
  		   :json => { success: true,
           friends: non_friend_users.as_json(:except => [:authentication_token])
        }
  end
end