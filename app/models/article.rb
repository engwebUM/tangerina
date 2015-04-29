#require 'sinatra/base'

class Article < ActiveRecord::Base
  belongs_to :article_review, dependent: :destroy
  #has_many :article_review, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy



  validates_attachment_content_type :file, content_type: [ 'application/pdf','text/plain']
  #scope :articles_accepts, -> { joins(:versions).where( {versions: {event: 'update'}, articles: {status: 'accept'}}) }
  #scope :versions_update, -> { PaperTrail::Version.where(event: 'update') }
  scope :accept, -> {where(status: 'accept')}
  #scope :order, -> {order(updated_at: :desc)}

  scope :favorite_user, lambda { |id| favorites.where(user_id: id) }


end
