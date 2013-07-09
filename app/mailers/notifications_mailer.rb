class NotificationsMailer < ActionMailer::Base

  default :to => ENV['GMAIL_USERNAME']

  def new_message(message)
    @message = message
    mail(from: message.email , :subject => "[SoacialMediaApp.tld] #{message.subject}")
  end

end

