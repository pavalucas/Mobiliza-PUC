class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show]

	def show
	    @user = User.find(params[:id])
	    @mobilizations = @user.mobilizations
  	end

  	def user_params
      params.require(:user).permit(:name)
    end

  	def signed_in_user
      store_location
      redirect_to signin_url, notice: "Você não está logado." unless signed_in?
    end

end
