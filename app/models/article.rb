class Article < ActiveRecord::Base
  belongs_to :theme
  belongs_to :user

  has_many :comments, dependent: :destroy

  acts_as_taggable
  acts_as_taggable_on :tags
  validates_presence_of :tag_list
  has_attached_file :file

  validates_presence_of :theme_id

  validates_attachment_content_type :file, :content_type => [ 'application/pdf','text/plain']
end
