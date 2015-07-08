class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :occupation, :string
    add_column :users, :about, :text
    add_column :users, :date_birth, :date
  end
end
