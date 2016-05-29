class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show]

	def show
	    @user = current_user
	    @mobilizations = @user.mobilizations
  	end

	private
	  	def signed_in_user
	      store_location
	      redirect_to "/auth/facebook" unless signed_in?
	    end

end
