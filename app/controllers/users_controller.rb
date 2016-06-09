class UsersController < ApplicationController
	before_action :owner_user, only: [:show, :edit]

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
	  	def owner_user
	      redirect_to root_url unless params[:id] == current_user.id.to_s
	    end

	    def user_params
	      params.require(:user).permit(:email, :registration)
	    end
end
