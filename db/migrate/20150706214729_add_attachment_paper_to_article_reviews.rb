class AddAttachmentPaperToArticleReviews < ActiveRecord::Migration
  def self.up
    change_table :article_reviews do |t|
      t.attachment :paper
    end
  end

  def self.down
    remove_attachment :article_reviews, :paper
  end
end
