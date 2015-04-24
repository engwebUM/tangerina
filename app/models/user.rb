class User < ActiveRecord::Base
  include Clearance::User

  has_many :articles
  has_many :article_reviews
  has_many :comments
  #belongs_to :theme
  has_many :subscriptions

  accepts_nested_attributes_for :articles

  def self.find_version_author(version)
    find(version.terminator)
  end
end
