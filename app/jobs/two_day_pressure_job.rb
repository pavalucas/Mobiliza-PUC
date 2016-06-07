class TwoDayPressureJob < Struct.new(:mobilization_id)
	def perform
		@mobilization = Mobilization.find(mobilization_id)
		@mobilization.last_sent_email = DateTime.now
        Delayed::Job.enqueue(TwoDayPressureJob.new(@mobilization.id), run_at: @mobilization.last_sent_email + 2.days)
		@mobilization.targets.each do |target|      
	  		UserMailer.pressure_mail(@mobilization, target).deliver_later
		end
	end
end
