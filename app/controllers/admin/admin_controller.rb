module Admin
  class AdminController < ApplicationController
    before_filter :require_login, :authorize
    skip_before_filter :verify_authenticity_token

    private

    def authorize
      redirect_to root_path unless current_user.admin?
    end
  end
end
