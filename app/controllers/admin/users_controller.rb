module Admin
  class UsersController < AdminController
    before_filter :require_login, :authorize
    
    def index
    end
  end
end
