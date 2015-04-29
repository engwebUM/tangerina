class AddFieldsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subject, :string
    add_column :subscriptions, :notify, :boolean
  end
end
