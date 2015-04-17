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

  has_paper_trail class_name: 'ArticleVersion', on: [:update, :create], class_name: 'ArticleVersion'

  scope :reviews_creates, -> { joins(:versions).where({versions: {event: 'create'}, articles: {status: 'pending'}}) }
  scope :reviews_updates, -> { joins(:versions).where({versions: {event: 'update'}, articles: {status: 'pending'}}) }

  #scope :articles_accepts, -> { joins(:versions).where( {versions: {event: 'update'}, articles: {status: 'accept'}}) }
  #scope :versions_update, -> { PaperTrail::Version.where(event: 'update') }
  scope :accept, -> {where(status: 'accept')}
  #scope :order, -> {order(updated_at: :desc)}
end
