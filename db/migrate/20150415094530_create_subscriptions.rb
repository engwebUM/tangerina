class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :theme, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :themes
    add_foreign_key :subscriptions, :users
  end
end
