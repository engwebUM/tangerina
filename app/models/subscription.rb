class Subscription < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :theme_id

  end
