class ReviewsController < ApplicationController
  before_action :set_article, only: :show
  before_action :require_login
  def index
    #@versions = PaperTrail::Version.all
    #@article = Article.find(params[:id])
    @versions = PaperTrail::Version.all.where(event: 'update')
  end

  def show
    @article = Article.find(params[:item_id])
    @versions = @article.versions
    @article = @article.versions[params[:version].to_i].reify if params[:version]
    show!
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end
