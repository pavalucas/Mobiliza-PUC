class WelcomeController < ApplicationController
	def index
		@recentMobs = [Mobilization.order(created_at: :desc)[0],
						Mobilization.order(created_at: :desc)[1],
						Mobilization.order(created_at: :desc)[2]]
	end
end
