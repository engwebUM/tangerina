class Video < ActiveRecord::Base
  belongs_to :article_review
  regex = %r{(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})}
  validates_format_of :link, with: regex

  scope :youtube_id, ->(id) { find(id).link[regex, 1] }
end
