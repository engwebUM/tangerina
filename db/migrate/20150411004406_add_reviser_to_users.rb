class AddReviserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reviser, :boolean, default: false
  end
end
