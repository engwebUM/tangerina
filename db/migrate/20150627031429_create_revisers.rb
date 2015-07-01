class CreateRevisers < ActiveRecord::Migration
  def change
    create_table :revisers do |t|
      t.integer :user_id
      t.integer :theme_id

      t.timestamps null: false
    end
  end
end
