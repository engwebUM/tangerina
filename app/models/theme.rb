class Theme < ActiveRecord::Base
  att_url = '/assets/themes/:id/:style/:basename.:extension'
  att_path = ':rails_root/public/assets/themes/:id/:style/:basename.:extension'

  has_attached_file :image, styles: { small: '150x150>' }, url: att_url, path: att_path

  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: ['image/png', 'image/jpeg']

  has_many :article_reviews
  has_many :subscriptions

  validates_presence_of :name
  accepts_nested_attributes_for :article_reviews
end
