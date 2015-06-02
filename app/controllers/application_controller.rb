class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_filter :set_search
  protect_from_forgery with: :exception

  def permit_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_search
    @q = ArticleReview.joins(:articles).search(params[:q])
  end

  def authorize
    redirect_to root_path unless current_user.admin?
  end
end
