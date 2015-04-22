#require 'sinatra/base'

class Article < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  has_many :comments, dependent: :destroy
#  register PaperTrail::Sinatra
  acts_as_taggable
  acts_as_taggable_on :tags
  validates_presence_of :tag_list
  has_attached_file :file

  validates_presence_of :theme_id

  validates_attachment_content_type :file, :content_type => [ 'application/pdf','text/plain']

  has_paper_trail

  scope :subscribed, lambda { |id| joins(theme: {subscriptions: :user}).where(subscriptions: {user_id: id })}

end
