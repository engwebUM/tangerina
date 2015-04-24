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
    end

    def set_article_review
      @article_review = ArticleReview.find(params[:id])
    end
end
