# t.string   "name"
# t.datetime "created_at",         null: false
# t.datetime "updated_at",         null: false
# t.string   "image_file_name"
# t.string   "image_content_type"
# t.integer  "image_file_size"
# t.datetime "image_updated_at"

class Theme < ActiveRecord::Base
  att_url = '/assets/themes/:id/:style/:basename.:extension'
  att_path = ':rails_root/public/assets/themes/:id/:style/:basename.:extension'

  has_attached_file :image, styles: { small: '150x150>' }, url: att_url, path: att_path
  has_attached_file :image, styles: { medium: '340x215>' }, url: att_url, path: att_path

  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: ['image/png', 'image/jpeg']

  has_many :article_reviews
  has_many :subscriptions
  has_many :revisers

  validates_presence_of :name
  accepts_nested_attributes_for :article_reviews
  accepts_nested_attributes_for :revisers

  scope :like, ->(args) { where "name LIKE '%#{args}%'" }
end
