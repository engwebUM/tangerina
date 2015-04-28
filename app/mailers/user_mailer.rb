class UserMailer < ActionMailer::Base
  default :from => "tangerina.ess@gmail.com"

  def users_notified(user)
    mail(:to => user.email, :subject => "Article test")
  end
end
