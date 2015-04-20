class CreateArticleReviews < ActiveRecord::Migration
  def change
    create_table :article_reviews do |t|
      t.integer :article_id
      t.string :title
      t.text :description
      t.integer :theme_id
      t.text :abstract
      t.integer :user_id
      t.string :status
      t.string :tag_list
      t.string :event
      t.text :comment
      
      t.timestamps null: false
    end
  end
end
