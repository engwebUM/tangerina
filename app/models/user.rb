class User < ActiveRecord::Base
  include Clearance::User

  att_url = '/assets/themes/:id/:style/:basename.:extension'
  att_path = ':rails_root/public/assets/themes/:id/:style/:basename.:extension'

  belongs_to :theme
  has_many :articles
  has_many :article_reviews
  has_many :comments
  has_many :favorites
  has_many :subscriptions
  has_many :revisers
  accepts_nested_attributes_for :articles
  accepts_nested_attributes_for :revisers

  has_attached_file :photo, styles: { avatar: '100x100>' }, url: att_url, path: att_path

  validates_attachment_content_type :photo, content_type: ['image/jpeg', 'image/png']

  def recommend?(article)
    favorites.where(article_id: article).present?
  end

  scope :normal, -> { where(admin: false) }
end
