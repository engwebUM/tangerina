class Theme < ActiveRecord::Base
  has_many :articles
  has_many :subscriptions
  validates_presence_of :name

  accepts_nested_attributes_for :articles
end
