class AddArticleReviewToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :article_review_id, :integer
  end
end
