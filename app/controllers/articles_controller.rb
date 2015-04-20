class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
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


  # POST /articles
  # POST /articles.json
  def create
    @article_review = ArticleReview.new(article_review_params)
    @article_review.event = 'create'
    @article_review.status = 'pending'
    @article_review.user_id = current_user.id
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

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    ArticleReview.removes(params[:id])
    @article_review = ArticleReview.new(article_params)
    @article_review.article_id = params[:id]
    @article_review.event = 'update'
    @article_review.status = 'pending'
    @article_review.user_id = current_user.id
    respond_to do |format|
      if @article_review.save
        format.html { redirect_to articles_url, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_view }
      else
        format.html { render :edit }
        format.json { render json: @article_view.errors, status: :unprocessable_entity }
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, :theme_id, :abstract, :user_id, :tag_list, :file, :status)
    end

    def article_review_params
      params.require(:article_review).permit(:article_id, :title, :description, :theme_id, :abstract, :user_id, :tag_list, :file, :status, :event)
    end
end
