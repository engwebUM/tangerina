class RemoveFilesFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :file_file_name, :string
    remove_column :articles, :file_content_type, :string
    remove_column :articles, :file_file_size, :integer
    remove_column :articles, :file_updated_at, :datetime
  end
end
