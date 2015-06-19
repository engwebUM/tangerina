class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_filter :set_search
  protect_from_forgery with: :exception

  def url_after_denied_access_when_signed_out
  	home_index_path
  end

  private

  def permit_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_search
    @q = ArticleReview.joins(:articles).search(params[:q])
  end
end
