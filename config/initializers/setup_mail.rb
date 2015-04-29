ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "tangerina.herokuapp.com",
  :user_name            => "tangerina.ess",
  :password             => "tangerinaess",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
