class ReviewsController < ApplicationController
  before_action :set_article, only: :show
  before_action :require_login
  def index
    #@versions = PaperTrail::Version.all
    #@article = Article.find(params[:id])
    @updates = PaperTrail::Version.all.where(event: 'update')
    @destroys = PaperTrail::Version.all.where(event: 'destroy')
    @creates = PaperTrail::Version.all.where(event: 'create')
  end

  def show
    @article = Article.find(params[:id])

  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
end
