class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :create_review, :edit, :destroy]
  before_action :set_publish, only: [:show, :create_review, :edit]
  before_action :require_login

  def index
    if params[:tag].present?
      @articles = ArticleReview.joins(:articles).tagged_with(params[:tag])
    elsif params[:q].present?
      @q = ArticleReview.joins(:articles).search(params[:q])
      @articles = @q.result
    else
      @articles = ArticleReview.joins(:articles).all
    end
  end

  def show
  end

  def new
    @article_review = ArticleReview.new
    @themes = Theme.all
  end

  def edit
    @themes = Theme.all
  end

  def create_review
    values_article_review
    respond_to do |format|
      if @article_review.save
        format.html { redirect_to articles_url, notice: 'This article is new please Wait for review!' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def favorite_user(id)
    @article.favorite_user(id)
  end

  def advanced_search
    # put any code here that you need
    # (although for a static view you probably won't have any)
  end

  private

  def set_article
    @article = Article.find_by(article_review_id: params[:id])
    rescue
      nil
    end
  end

  def set_publish
    @publish = @article.article_review
  end

  def values_article_review
    @article_review = ArticleReview.new(article_review_params)
    @article_review.status = 'pending'
    @article_review.user_id = current_user.id

    if @publish.present?
      @article_review.article_id = @article.id
      @article_review.event = 'update'
    else
      @article_review.event = 'create'
    end
  end

  def article_review_params
    params.require(:article_review).permit(:article_id, :title, :description, :theme_id, :abstract, :user_id, :tag_list, :file, :status, :event)
  end
end
