module ArticlesHelper
  include ActsAsTaggableOn::TagsHelper

  def find_version_author_name(version)
    user = User.find_version_author(version)
    user ? user.username : ''
  end

  def get_users_subscriptions(article)
  	subscriptions = Subscription.all

  	subscriptions.theme.each do |theme|
  		if article.theme.id == theme.id
  			notifie_users(subscriptions.user)
  		end
  	end		
  end	

  def notifie_users(users)
  	users.each do |user|
  		UserMailer.registration_confirmation(user).deliver
  	end
  end  	
end
