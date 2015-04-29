class ReviewsController < ApplicationController
  before_action :set_article_review, only: [:show, :accept, :reject]
  before_action :require_login

  def index
    @creates = ArticleReview.creates
    @updates = ArticleReview.updates
  end

  def show
  end

  def reject
    @article_review.update(status: 'reject')
    redirect_to root_path
  end

  def accept
    ArticleReview.where(article_id: @article_review.article_id, status: 'accept').destroy_all
    @article_review.update(status: 'accept')
    new_article(@article_review)
    get_users_subscriptions(@article_review)
    redirect_to root_path
  end

  private

  def new_article(article_review)
    article = Article.find(article_review.article_id)
    rescue
      nil
    end

    if article.nil?
      article = Article.new
    end
    article.article_review_id = article_review.id
    article.save
    if Article.last.article_review.event == 'create'
      Article.last.article_review.update(article_id: Article.last.id)
    end
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
