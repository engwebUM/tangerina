class HomeController < SessionsController
  before_filter :redirect_signed_in_users

  def index
  end
end
