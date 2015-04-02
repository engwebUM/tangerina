class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.integer :theme_id
      t.text :abstract
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
