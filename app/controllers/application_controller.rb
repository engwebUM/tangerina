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

  def authenticate_admin_user!
    redirect_to sign_in_path unless current_user.try(:admin?)
  end
end
