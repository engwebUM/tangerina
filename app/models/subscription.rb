class Subscription < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  validates :theme_id, uniqueness: { scope: :user_id, message: 'has been already chosen' }
  
end
