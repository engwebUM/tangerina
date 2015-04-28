class ArticleReview < ActiveRecord::Base
  has_many :articles
  belongs_to :theme
  belongs_to :user

  acts_as_taggable
  acts_as_taggable_on :tags
  validates_presence_of :tag_list
  has_attached_file :file
  accepts_nested_attributes_for :articles
  validates_presence_of :theme_id
  validates_attachment_content_type :file, :content_type => [ 'application/pdf','text/plain']

  scope :creates, -> { where(event: 'create', status: 'pending') }
  scope :updates, -> { where(event: 'update', status: 'pending') }
  scope :removes, lambda { |id| where(article_id: id).destroy_all }
  scope :subscribed, lambda { |id| joins(theme: { subscriptions: :user } ).where(subscriptions: { user_id: id }).joins(:articles) }
end
