class Subscription < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user
end
