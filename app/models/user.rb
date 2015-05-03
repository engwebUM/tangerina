class User < ActiveRecord::Base
  include Clearance::User

  belongs_to :theme
  has_many :articles
  has_many :article_reviews
  has_many :comments
  has_many :favorites
  has_many :subscriptions
  accepts_nested_attributes_for :articles

  def recommend?(article)
    favorites.where(article_id: article).present?
  end
end
