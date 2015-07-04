class AddDatesArticleReviews < ActiveRecord::Migration
  def change
    add_column :article_reviews, :date_accepted, :date
    add_column :article_reviews, :date_writted, :date
  end
end
