class AddAttachmentFileToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :articles, :file
  end
end
