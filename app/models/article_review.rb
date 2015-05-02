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
  validates_attachment_content_type :file, content_type: ['application/pdf', 'text/plain']

  scope :creates, -> { where(event: 'create', status: 'pending') }
  scope :updates, -> { where(event: 'update', status: 'pending') }
  scope :removes, ->(id) { where(article_id: id).destroy_all }
  scope :subscribed, ->(id) { includes(theme: { subscriptions: :user }).where(users: { id: id }).joins(:articles) }
  scope :paginated, ->(page) { paginate(page: page, per_page: 2) }
  scope :tag_page, ->(tag) { tagged_with(tag) }
  scope :search_page, ->(q) { search(q).result }
end
