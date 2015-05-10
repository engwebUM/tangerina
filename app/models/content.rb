class Content < ActiveRecord::Base
  belongs_to :article_review

  has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :file,
          content_type: ['application/pdf', 'text/plain', 'image/jpeg'],
          presence: true,
          size: { less_than: 1.megabyte }
end
