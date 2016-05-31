class ApplicationMailer < ActionMailer::Base
  default from: "miguel.corti36@gmail.com"

  def mobCreation_mail(mobilization)
  	@mobilization = mobilization
  	@mobilization.targets.each do |target|
  		mail(to: target.email, subject: 'Você está sendo pressionado!')
  	end
  end
end
