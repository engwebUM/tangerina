class Theme < ActiveRecord::Base
  has_many :article_reviews
  has_many :subscriptions

  validates_presence_of :name
  accepts_nested_attributes_for :article_reviews
end
