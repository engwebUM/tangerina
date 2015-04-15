class ReviewsController < ApplicationController
  before_action  only: :show
  before_action :require_login
  def index
    #@versions = PaperTrail::Version.all
    #@article = Article.find(params[:id])
    #@updates = PaperTrail::Version.all.where(event: 'update')
    @updates = Article.all.where(status: "pending").joins(:versions).where({versions: {event: "update"}})
    @destroys = PaperTrail::Version.all.where(event: 'destroy')
    @creates = PaperTrail::Version.all.where(event: 'create')

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
    redirect_to root_path, notice: 'The object was successfully brought back!'
  end
end
