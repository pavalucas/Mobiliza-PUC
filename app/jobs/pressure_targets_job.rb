class PressureTargetsJob

  def initialize(mob_id)
    self.mobilization_id = mob_id
  end
  
  def perform
  	@mobilization = Mobilization.find(mobilization_id)
  	@mobilization.last_sent_email = DateTime.now
    @mobilization.targets.each do |target|      
      UserMailer.pressure_mail(@mobilization, target).deliver_later
    end
  end

  def queue_name
    'pressure_mail'
  end

  def max_attempts
    3
  end
end
