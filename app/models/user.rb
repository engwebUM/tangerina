class User < ActiveRecord::Base
  include Clearance::User

  belongs_to :theme
  has_many :articles
  has_many :article_reviews
  has_many :comments
  has_many :favorites
  has_many :subscriptions
  has_many :revisers
  accepts_nested_attributes_for :articles
  accepts_nested_attributes_for :revisers

  def recommend?(article)
    favorites.where(article_id: article).present?
  end

  scope :normal, -> { where(admin: false) }
end
