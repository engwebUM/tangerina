class Comment < ActiveRecord::Base
  belongs_to :article
  # belongs_to :article_published
  belongs_to :user
end
