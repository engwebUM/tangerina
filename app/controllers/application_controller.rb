class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 	before_filter :set_search

  protect_from_forgery with: :exception

  def permit_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_search
    @q=ArticleReview.joins(:articles).search(params[:q])
  end


end
