class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :create_review, :edit, :destroy]
  before_action :set_publish, only: [:show, :create_review, :edit]
  before_action :require_login

  def index
    @articles = if params[:tag].blank? && params[:q].blank?
                  articles_publish.paginated(params[:page])
                else
                  list_articles
                end
    @themes = Theme.all
  end

  def list_articles
    if params[:tag].present?
      articles_publish.tag_page(params[:tag])
    elsif params[:q].present?
      articles_publish.search_page(params[:q])
    end
  end

  def show
    @files = @publish.contents.all
  end

  def new
    @article_review = ArticleReview.new
    @article_review.contents.build
    @article_review.videos.build
    @themes = Theme.all
  end

  def edit
    @themes = Theme.all
  end

  def create_review
    values_article_review
    # respond_to do |format|
    if @article_review.save
      create_files if params[:contents].present?
      create_videos if params[:videos].present?

      redirect_to articles_url
      # format.html { redirect_to articles_url, notice: 'This article is new please Wait for review!' }
      # format.json { render :show, status: :created, location: @article }
    else
      render :new
      # format.html { render :new }
      # format.json { render json: @article.errors, status: :unprocessable_entity }
    end
    # end
  end

  def destroy
    @article.destroy
    redirect_to articles_url
    # respond_to do |format|
    # format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    # format.json { head :no_content }
    # end
  end

  def favorite_user(id)
    @article.favorite_user(id)
  end

  def advanced_search
    # put any code here that you need
    # (although for a static view you probably won't have any)
  end

  private

  def create_videos
    params[:videos]['link'].each do |v|
      @article_review.videos.create!(link: v, article_review_id: @article_review.id)
    end
  end

  def create_files
    params[:contents]['file'].each do |c|
      @article_review.contents.create!(file: c, article_review_id: @article_review.id)
    end
  end

  def articles_publish
    ArticleReview.joins(:articles).all.paginated(params[:page])
  end

  def set_article
    @article = Article.find_by(article_review_id: params[:id])
                rescue
                  nil
  end

  def set_publish
    @publish =
              if @article.nil?
                @article
              else
                @article.article_review
              end
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
    params.require(:article_review).permit(:article_id, :title, :description, :theme_id, :abstract, :authors, :date_writted, :date_accepted, :paper, :user_id, :tag_list, :status, :event, :videos, :contents)
  end
end
