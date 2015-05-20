class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.attachment :file

      t.timestamps null: false
    end
  end
end
