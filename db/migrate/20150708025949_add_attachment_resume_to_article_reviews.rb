class AddAttachmentResumeToArticleReviews < ActiveRecord::Migration
  def self.up
    change_table :article_reviews do |t|
      t.attachment :resume
    end
  end

  def self.down
    remove_attachment :article_reviews, :resume
  end
end
