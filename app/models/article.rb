#require 'sinatra/base'

class Article < ActiveRecord::Base
  #belongs_to :theme
  belongs_to :user
  belongs_to :article_review, dependent: :destroy
  #has_many :article_review, dependent: :destroy
  has_many :comments, dependent: :destroy

  #validates_presence_of :theme_id

  scope :reviews_creates, -> { joins(:versions).where({versions: {event: 'create'}, articles: {status: 'pending'}}) }
  scope :reviews_updates, -> { joins(:versions).where({versions: {event: 'update'}, articles: {status: 'pending'}}) }

  #scope :articles_accepts, -> { joins(:versions).where( {versions: {event: 'update'}, articles: {status: 'accept'}}) }
  #scope :versions_update, -> { PaperTrail::Version.where(event: 'update') }
  scope :accept, -> {where(status: 'accept')}
  #scope :order, -> {order(updated_at: :desc)}
  
end
