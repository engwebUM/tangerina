class Theme < ActiveRecord::Base
  has_many :article_reviews
  has_many :subscriptions
  has_many :revisers

  validates_presence_of :name
  accepts_nested_attributes_for :article_reviews
  accepts_nested_attributes_for :revisers
end
