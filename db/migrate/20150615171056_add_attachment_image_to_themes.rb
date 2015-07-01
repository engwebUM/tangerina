class AddAttachmentImageToThemes < ActiveRecord::Migration
  def self.up
    change_table :themes do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :themes, :image
  end
end
