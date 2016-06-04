class ApplicationMailer < ActionMailer::Base
  default from: "mobpuc@mobiliza.com"

  def pressure_mail(mobilization, target)
  	@mobilization = mobilization
  	@target = target
  	mail(to: @target.email, subject: 'Você está sendo pressionado!')
  end
end
