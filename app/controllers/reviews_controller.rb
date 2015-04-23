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
    #ArticleReview.removes(@article_review.article_id)
    redirect_to root_path
  end

  private

    def new_article(article_review)
      article = Article.find(article_review.article_id) rescue nil
      if article.nil?
        article = Article.new
      end
      article.article_review_id = article_review.id
      #passing_values(article, article_review)
      article.save
    end

    def passing_values(article, article_review)
      article.title = article_review.title
      article.description = article_review.description
      article.theme_id = article_review.theme_id
      article.abstract = article_review.abstract
      article.user_id = article_review.user_id
      article.status = article_review.status
      article.created_at = article_review.created_at
      article.updated_at = article_review.updated_at
      article.tag_list = article_review.tag_list
      article.file_file_name = article_review.file_file_name
      article.file_content_type = article_review.file_content_type
      article.file_file_size = article_review.file_file_size
      article.file_updated_at = article_review.file_updated_at
    end

    def set_article_review
      @article_review = ArticleReview.find(params[:id])
    end
end
