# t.datetime "created_at",                                     null: false
# t.datetime "updated_at",                                     null: false
# t.string   "email",                                          null: false
# t.string   "encrypted_password", limit: 128,                 null: false
# t.string   "confirmation_token", limit: 128
# t.string   "remember_token",     limit: 128,                 null: false
# t.string   "username"
# t.datetime "confirmed_at"
# t.boolean  "admin",                          default: false

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

  scope :like, ->(args) { where "username LIKE '%#{args}%'" }
end
