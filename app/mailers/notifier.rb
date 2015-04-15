class Notifier < ApplicationMailer
	default from: 'notifications@example.com'
 
  def user_message(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: tangerina@gmail.com, subject: 'New Notification')
  end
end
