class ApplicationMailer < ActionMailer::Base
  default from: "postmaster@mobpuc.com.br"

  def pressure_mail(mobilization, target)
  	@mobilization = mobilization
  	@target = target
    #mg_client = Mailgun::Client.new ENV['api_key']
    #me = {:from    => 'mobpuc@mobiliza.com',
    #                  :to      => @target.email,
    #                  :subject => 'Você está sendo pressionado!',
    #                  :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    #mg_client.send_message ENV['domain'], message_params

  	mail(to: @target.email, subject: 'Você está sendo pressionado!')
  end

  def creation_mail(user)
  	@user = user
    #mg_client = Mailgun::Client.new ENV['api_key']
    #message_params = {:from    => 'mobpuc@mobiliza.com',
    #                  :to      => @user.email,
    #                  :subject => 'Você criou uma mob!',
    #                  :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    #mg_client.send_message ENV['domain'], message_params
  	mail(to: @user.email, subject: 'Você criou uma mob!')
  end

  def supportMob_mail(mobilization, user)
  	@user = user
  	@mobilization = mobilization
    #mg_client = Mailgun::Client.new ENV['api_key']
    #message_params = {:from    => 'mobpuc@mobiliza.com',
    #                  :to      => @user.email,
    #                  :subject => 'Você pressionou uma mob!',
    #                  :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    #mg_client.send_message ENV['domain'], message_params
  	mail(to: @user.email, subject: 'Você pressionou uma mob!')
  end
end
