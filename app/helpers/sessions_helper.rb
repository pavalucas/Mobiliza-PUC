module SessionsHelper

	def signed_in?
    	!current_user.nil?
  	end

  	def store_location
      session[:return_to] = request.url if request.get?
    end
end
