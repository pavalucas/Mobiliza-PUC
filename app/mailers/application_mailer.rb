class ApplicationMailer < ActionMailer::Base
  default from: "mobiliza@mobpuc.com.br"

  def damn(email, assunto, conteudo)
    @subject = assunto
    @content = conteudo
    mail(to: email, subject: assunto)
  end

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

  	mail(to: @user.email, subject: 'Você pressionou uma mob!')
  end

  def reachGoal_mail(mobilization, user)
    @user = user
    @mobilization = mobilization

    mail(to: @user.email, subject: 'Faltam apenas 10!')
  end
end
