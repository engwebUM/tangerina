class Article < ActiveRecord::Base
  belongs_to :article_review, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  scope :accept, -> { where(status: 'accept') }
  scope :favorite_user, -> (id) { favorites.where(user_id: id) }
  scope :ends, -> { last.article_review }
end
