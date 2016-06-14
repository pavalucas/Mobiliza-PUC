class TwoDayPressureJob

  	def initialize(mob_id)
    	self.mobilization_id = mob_id
  	end
  	
	def perform
		@mobilization = Mobilization.find(mobilization_id)
		@mobilization.last_sent_email = DateTime.now
        Delayed::Job.enqueue(TwoDayPressureJob.new(@mobilization.id), :run_at => (@mobilization.last_sent_email + 2.days))
		@mobilization.targets.each do |target|      
	  		UserMailer.pressure_mail(@mobilization, target).deliver_later
		end
	end

	def queue_name
    	'2_day_mail'
  	end

  	def max_attempts
    	3
  	end
end
