module Admin
  class DashboardController < AdminController
    before_filter :authorize

    def index
    end
  end
end
