class Content < ActiveRecord::Base
  belongs_to :article_review

  has_attached_file :file

  validates_attachment_content_type :file, content_type: ['application/pdf', 'image/jpeg', 'image/png']

  scope :find_images, -> { where("file_content_type LIKE '%image%'") }
  scope :find_pdf, -> { where(file_content_type: 'application/pdf') }
end
