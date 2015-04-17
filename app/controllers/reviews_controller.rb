class ReviewsController < ApplicationController
  before_action  only: :show
  before_action :require_login
  def index
    @updates = Article.reviews_updates
    @creates = Article.reviews_creates
  end

  def show
    @article = Article.find(params[:id])
  end

  def reject
    a = Article.find(params[:id])
    a = a.versions.last.reify
    a.save
    PaperTrail::Version.all.where(item_id: params[:id]).delete_all
    a.status = "reject"
    a.save
    redirect_to root_path
  end

  def accept
    a = Article.find(params[:id])
    a.status = "accept"
    a.save
    PaperTrail::Version.all.where(item_id: params[:id]).delete_all
    redirect_to root_path
  end
end
