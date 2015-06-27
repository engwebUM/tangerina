module Admin
  class RevisersController < AdminController
    before_action :set_reviser, only: :destroy
    before_action :require_login, :authorize

    def index
      @revisers = Reviser.all
      @reviser = Reviser.new
      @user = User.new
      @themes = Theme.all
    end

    def create
      @reviser = Reviser.new(reviser_params)
      @reviser.save
      redirect_to admin_revisers_url
    end

    def destroy
      @reviser.destroy
      redirect_to admin_revisers_url
    end

    private

    def set_reviser
      @reviser = Reviser.find(params[:id])
    end

    def reviser_params
      params.require(:reviser).permit(:user_id, :theme_id)
    end
  end
end
