class AddUserTypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :integer, :default => 3
  end
end
