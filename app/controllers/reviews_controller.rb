class ReviewsController < ApplicationController
  before_action :set_article_review, only: [:show, :accept, :reject]
  before_action :require_login

  def index
    @creates = ArticleReview.creates
    @updates = ArticleReview.updates
  end

  def show
    @contents = Content.where(article_review_id: @article_review.id)
    @videos = Video.where(article_review_id: @article_review.id)
  end

  def reject
    @article_review.update(status: 'reject')
    redirect_to root_path
  end

  def accept
    @article_review.update(status: 'accept')
    new_article(@article_review)
    get_users_subscriptions(@article_review)
    ArticleReview.where(article_id: @article_review.article_id, status: 'accept').destroy_all
    redirect_to root_path
  end

  private

  def rescue_article(article_review)
    Article.find(article_review.article_id)
    rescue
      nil
  end

  def new_article(article_review)
    article = rescue_article(article_review)
    article = Article.new if article.nil?
    article.article_review_id = article_review.id
    article.save
    Article.ends.update(article_id: Article.last.id) if Article.ends.event == 'create'
  end

  def get_users_subscriptions(article)
    @subscriptions = Subscription.where(theme_id: article.theme_id, notify: true)
    @subscriptions.each do |subscription|
      UserMailer.users_notified(subscription.user, article).deliver
    end
  end

  def set_article_review
    @article_review = ArticleReview.find(params[:id])
  end
end
