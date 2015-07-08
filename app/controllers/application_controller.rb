class ApplicationController < ActionController::Base
  include Clearance::Controller

  before_filter :set_search
  protect_from_forgery with: :exception

  private

  def authorized_reviser
    redirect_to root_path unless current_user?
  end

  def current_user?
    current_user.revisers.present? || current_user.admin?
  end

  def permit_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name, :city, :country, :occupation, :about, :date_birth, :photo)
  end

  def set_search
    @q = ArticleReview.joins(:articles).search(params[:q])
  end

  def url_after_denied_access_when_signed_out
    '/home'
  end

  def url_after_denied_access_when_signed_in
    root_path
  end
end
