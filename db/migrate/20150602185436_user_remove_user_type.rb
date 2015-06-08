class UserRemoveUserType < ActiveRecord::Migration
  def change
    remove_column :users, :reviser, :boolean
    remove_column :users, :user_type, :integer
  end
end
