class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@mobpuc.com.br"

  def pressure_mail(mobilization, target)
  	@mobilization = mobilization
  	@target = target

  	mail(to: @target.email, subject: @mobilization.title)
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

  	mail(to: @user.email, subject: 'Você apoiou uma mob!')
  end

  def reachGoal_mail(mobilization, distanceToGoal)
    @mobilization = mobilization
    @user = User.find(@mobilization.user_id)
    @distanceToGoal = distanceToGoal
    mail(to: @user.email, subject: 'Sua mob está bombando!')
  end
end
