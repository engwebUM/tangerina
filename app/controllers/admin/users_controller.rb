module Admin
  class UsersController < AdminController
    include SmartListing::Helper::ControllerExtensions
    helper SmartListing::Helper
    
    before_filter :require_login, :authorize

    def index
      users_scope = User.all
      users_scope = users_scope.like(params[:filter]) if params[:filter]
      @users = smart_listing_create(:users, users_scope, partial: "admin/users/listing", default_sort: { username: "asc" })
    end
  end
end
