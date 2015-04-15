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

    if @article.versions.last.nil?
      set_article
    elsif @article.versions.last.event == 'create'
        @article = nil
    else
      @article = @article.versions.last.reify
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
    @themes = Theme.all
  end

  # GET /articles/1/edit
  def edit
    @themes = Theme.all

  end


  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article}
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
    @article.status = "pending"
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
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
    @q=Article.search(params[:q])
  end
  
  private

    def articles_all
      articles = Article.all
      @tempart = []
      articles.each do |a|
        if article_correct?(a)
          @tempart << a
        end
      end
    end

    def article_correct?(a)
      a.status == "accept" || (a.versions.last.event != "create"  && a.versions.last.reify.status == "accept")
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description, :theme_id, :abstract, :user_id, :tag_list, :file, :revised)
    end
  

    def article_versions
      if @article.versions.last.nil?
        @article
      elsif @article.versions.last.event == 'create'
        @article = nil
      else
        @article = @article.versions.last.reify
        #@article.save
      end
    end
end
