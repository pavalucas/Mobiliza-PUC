class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show]

	def show
	    @user = current_user
	    @mobilizations = @user.mobilizations
  	end

  	def signed_in_user
      store_location
      redirect_to signin_url, notice: "Você não está logado." unless signed_in?
    end

end
