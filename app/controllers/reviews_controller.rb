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
    @article_review.status = 'accept'
    article_new(@article_review)
    get_users_subscriptions(Article.find(@article_review.article_id))
    ArticleReview.where(article_id: @article_review.article_id, status: 'accept').destroy_all
    @article_review.update(status: 'accept')
    new_article(@article_review)
    redirect_to root_path
  end

  private

    def new_article(article_review)
      article = Article.find(article_review.article_id) rescue nil
      if article.nil?
        article = Article.new
      end
      article.article_review_id = article_review.id
      article.save
      if Article.last.article_review.event =='create'
        Article.last.article_review.update(article_id: Article.last.id)
      end
    end

    def set_article_review
      @article_review = ArticleReview.find(params[:id])
    end

    def get_users_subscriptions(article)
      @subscriptions = Subscription.all
      @subscriptions.each do |subscription|
        if article.theme.id == subscription.theme.id
          notify_users(subscription.user)
        end
      end
    end

    def notify_users(users)
      UserMailer.users_notified(users).deliver
    end

end
