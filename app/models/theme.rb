class Theme < ActiveRecord::Base
  has_attached_file :image, styles: { small: "150x150>" },
                  url: '/assets/themes/:id/:style/:basename.:extension',
                  path: ':rails_root/public/assets/themes/:id/:style/:basename.:extension'

  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: ['image/png', 'image/jpeg']


  has_many :article_reviews
  has_many :subscriptions

  validates_presence_of :name
  accepts_nested_attributes_for :article_reviews
end
