class UserMailer < ActionMailer::Base
  default from: 'tangerina.ess@gmail.com'

  def users_notified(user, article)
    @user = user
    @article = article
    @subtxt = ''

    if (article.event == 'create')
      @subtxt = 'New'
    else
      @subtxt = 'Update'
    end

    mail(to: user.email, subject: "#{@subtxt} Article with theme #{article.theme.name}")
  end
end
