class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :create_review, :edit, :destroy]
  before_action :set_publish, only: [:show, :create_review, :edit]
  before_action :require_login
  before_filter :set_search
  # GET /articles
  # GET /articles.json
  def index
    if params[:tag].present?
      @articles = Article.tagged_with(params[:tag])
    elsif params[:q].present?
      @q = Article.search(params[:q])
      @articles = @q.result
    else
      @articles = Article.all
    end

  end

  # GET /articles/1
  # GET /articles/1.json
  def show

  end

  # GET /articles/new
  def new
    @article_review = ArticleReview.new
    @themes = Theme.all
  end

  # GET /articles/1/edit
  def edit
    @themes = Theme.all
  end

  def create_review
    values_article_review

    respond_to do |format|
      if @article_review.save
        format.html { redirect_to articles_url, notice: 'This article is new please Wait for review!' }
        get_users_subscriptions(@article)
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def advanced_search
    # put any code here that you need
    # (although for a static view you probably won't have any)
  end

  def set_search
  end

  def set_search
    @q=Article.search(params[:q])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id]) rescue nil
    end

    def set_publish
      @publish = @article.article_review rescue nil
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
