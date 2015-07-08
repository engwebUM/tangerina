class Content < ActiveRecord::Base
  belongs_to :article_review

  has_attached_file :file, styles: { normal: '500x500>' }
  validates_attachment_size :file, less_than: 3.megabytes
  validates_attachment_content_type :file, content_type: ['image/jpeg', 'image/png']
end
