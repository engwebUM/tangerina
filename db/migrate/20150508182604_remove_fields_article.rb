class RemoveFieldsArticle < ActiveRecord::Migration
  def change
    remove_column :article_reviews, :file_file_name, :string
    remove_column :article_reviews, :file_content_type, :string
    remove_column :article_reviews, :file_file_size, :integer
    remove_column :article_reviews, :file_updated_at, :datetime
  end
end
