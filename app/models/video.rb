class Video < ActiveRecord::Base
  belongs_to :article_review

  validates_format_of :link, with: /((https?:\/\/(.*youtube\.com\/watch.*|.*\.youtube\.com\/v\/.*|youtu\.be\/.*|.*\.youtube\.com\/user\/.*|.*\.youtube\.com\/.*#.*\/.*|m\.youtube\.com\/watch.*|m\.youtube\.com\/index.*|.*\.youtube\.com\/profile.*|.*\.youtube\.com\/view_play_list.*|.*\.youtube\.com\/playlist.*|www\.youtube\.com\/embed\/.*|youtube\.com\/gif.*|www\.youtube\.com\/gif.*))|(https:\/\/(.*youtube\.com\/watch.*|.*\.youtube\.com\/v\/.*|.*\.youtube\.com\/playlist.*|www\.youtube\.com\/embed\/.*|youtube\.com\/gif.*|www\.youtube\.com\/gif.*)))/i
end
