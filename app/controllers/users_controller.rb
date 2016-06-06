class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show, :edit]

	def show
	    @user = current_user
	    @mobilizations = @user.mobilizations
	    otherMobs = Mobilization.all - @mobilizations
	    @pressedMobs = []
	    otherMobs.each do |mob|
	    	if (@user.voted_for? mob) then
	    		@pressedMobs<< mob
	    	end
	    end
  	end
	def edit
  		@user = current_user
  	end

  	def update
  		@user = current_user
	    if @user.update_attributes(user_params)
	      flash[:success] = "Perfil Atualizado"
	      redirect_to @user
	    else
	      render 'edit'
	    end
	  end

	private
	  	def signed_in_user
	      store_location
	      redirect_to "/auth/facebook" unless signed_in?
	    end

	    def user_params
	      params.require(:user).permit(:email, :registration)
	    end

end
