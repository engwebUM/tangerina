class ReviewsController < ApplicationController
  before_action :require_login
  def index
    
    @articles = Article.all
  end

  def show
  end
end
