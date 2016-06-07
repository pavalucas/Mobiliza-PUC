class ApplicationMailer < ActionMailer::Base
  default from: "mobpuc@mobiliza.com"

  def pressure_mail(mobilization, target)
  	@mobilization = mobilization
  	@target = target
  	mail(to: @target.email, subject: 'Você está sendo pressionado!')
  end

  def creation_mail(user)
  	@user = user
  	mail(to: @user.email, subject: 'Você criou uma mob!')
  end

  def supportMob_mail(mobilization, user)
  	@user = user
  	@mobilization = mobilization
  	mail(to: @user.email, subject: 'Você pressionou uma mob!')
  end
end
