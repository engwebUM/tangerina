class User < ActiveRecord::Base
  include Clearance::User

  has_many :articles
  has_many :comments

  accepts_nested_attributes_for :articles
  
end
