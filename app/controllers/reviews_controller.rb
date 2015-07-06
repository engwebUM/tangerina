class ReviewsController < ApplicationController
  before_action :set_article_review, only: [:show, :accept, :reject]
  before_action :require_login, :authorized_reviser
  before_action :authorized_single_review, only: [:show, :accept, :reject]

  def index
    @creates = review_creates
    @updates = review_updates
  end

  def show
    @contents = Content.where(article_review_id: @article_review.id)
    @videos = Video.where(article_review_id: @article_review.id)
  end

  def reject
    @article_review.update(status: 'reject')
    @article_review.update(review_params)
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

  def review_creates
    if current_user.admin?
      ArticleReview.creates
    else
      ArticleReview.creates.revised(current_user.id)
    end
  end

  def review_updates
    if current_user.admin?
      ArticleReview.updates
    else
      ArticleReview.updates.revised(current_user.id)
    end
  end

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

  def review_params
    params.require(:article_review).permit(:comment)
  end

  def authorized_single_review
    redirect_to :back unless auth_current_user?
  end

  def auth_current_user?
    ArticleReview.revised(current_user.id).exists?(id: @article_review.id) || current_user.admin?
  end
end
