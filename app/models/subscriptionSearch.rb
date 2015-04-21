class SubscriptionSearch < SimpleDelegator
  
	 def themes_subscribed
    @subscriptions = Subscription.all
    themes = []

    @subscriptions.each do |subscription|
      if subscription.user.id == current_user.id
        themes << subscription.theme.name
      end
    end  
    themes
  end
  
end
