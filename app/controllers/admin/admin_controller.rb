module Admin
  class AdminController < ApplicationController
    before_filter :require_login, :authorize

    private

    def authorize
      redirect_to root_path unless current_user.admin?
    end
  end
end
