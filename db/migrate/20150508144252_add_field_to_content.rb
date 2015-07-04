class AddFieldToContent < ActiveRecord::Migration
  def change
    add_column :contents, :article_review_id, :integer
  end
end
