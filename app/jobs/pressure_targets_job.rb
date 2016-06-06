class PressureTargetsJob < ActiveJob::Base
  queue_as :default

  def perform(mobilization)
  	@mobilization = mobilization
    @mobilization.targets.each do |target|      
      UserMailer.pressure_mail(@mobilization, target).deliver_later
    end
  end
end
