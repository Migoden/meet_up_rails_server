class FriendshipsController < ApplicationController
 
  before_filter :authenticate_user_from_token!

  before_filter :authenticate_user!

  skip_before_filter :verify_authenticity_token,
                :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
  	@friendship = current_user.friendships.build(requested_friend_id: params[:requested_friend_id])
  	requested_user = User.find(params[:requested_friend_id])
  
  	if (@friendship.save)
  		status = 'friend request created'
  		if current_user.inverse_requested_friends.include?(@requested_user)
			  status = 'You are now friends'
  		end
  		render :status => 200,
	  		   json: { success: true, status: status} 
  	else
	 	render :status => :unprocessable_entity,
     	:json => { :success => false,
                :info =>  @friendship.errors
                	}
  	end
  end

  def destroy
  	# @friendship = Friendship.find(params[:id])
  	@friendship = current_user.friendships.find(params[:id])
  	# notify removed friend
  	@friendship.destroy
  	if @friendship.destroyed?
		render :status => 200,
  		   :json => { success: true}
  	else
  		render :status => :unprocessable_entity,
     	:json => { :success => false,
                :info => @friendship.errors}
  	end
  end
end
