class Video < ActiveRecord::Base
  belongs_to :article_review

  validates_format_of :link, with: /(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/
end
