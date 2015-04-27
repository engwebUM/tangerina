class RemoveFieldsFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :title, :string
    remove_column :articles, :description, :text
    remove_column :articles, :theme_id, :integer
    remove_column :articles, :abstract, :text
    remove_column :articles, :user_id, :integer
    remove_column :articles, :status, :string
  end
end
