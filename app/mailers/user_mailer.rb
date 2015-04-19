class UserMailer < ActionMailer::Base  
  default :from => "tangerina@gmail.com"  
  
  def users_notified(user)  
    mail(:to => user.email, :subject => "Registered")  
  end  
end 