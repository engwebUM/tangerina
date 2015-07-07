class AddAuthorToArticleReview < ActiveRecord::Migration
  def change
    add_column :article_reviews, :authors, :string
  end
end
