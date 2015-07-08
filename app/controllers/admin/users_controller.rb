module Admin
  class UsersController < AdminController
    before_action :require_login, :authorize

    def index
      @users = User.all
    end
  end
end
