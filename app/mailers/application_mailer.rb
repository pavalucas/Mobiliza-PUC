class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@mobpuc.com.br"

  def pressure_mail(mobilization, target)
  	@mobilization = mobilization
  	@target = target

  	mail(to: @target.email, subject: 'Você está sendo pressionado!')
  end

  def creation_mail(user)
  	@user = user

  	mail(to: @user.email, subject: 'Você criou uma mob!')
  end

  def edited_mail(mobilization, user)
    @user = user
    @mobilization = mobilization

    mail(to: @user.email, subject: 'Uma mob foi alterada!')
  end

  def supportMob_mail(mobilization, user)
  	@user = user
  	@mobilization = mobilization

  	mail(to: @user.email, subject: 'Você pressionou uma mob!')
  end

  def reachGoal_mail(mobilization, user)
    @user = user
    @mobilization = mobilization

    mail(to: @user.email, subject: 'Faltam apenas 10!')
end
