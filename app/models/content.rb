class Content < ActiveRecord::Base
  belongs_to :article_review

  has_attached_file :file
  validates_attachment_content_type :file, content_type: ['application/pdf', 'text/plain', /\Aimage\/.*\Z/]
end
