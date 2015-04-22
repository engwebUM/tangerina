class AddAttachmentFileToArticleReviews < ActiveRecord::Migration
  def self.up
    change_table :article_reviews do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :article_reviews, :file
  end
end
