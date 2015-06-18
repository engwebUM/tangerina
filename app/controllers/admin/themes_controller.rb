module Admin
  class ThemesController < AdminController
    include SmartListing::Helper::ControllerExtensions
    helper SmartListing::Helper

    before_action :set_theme, only: [:edit, :update, :destroy]
    before_filter :require_login, :authorize

    def index
      themes_scope = Theme.all
      themes_scope = Theme.like(params[:filter]) if params[:filter]
      @themes = smart_listing_create(:themes, themes_scope, partial: 'admin/themes/listing')
    end

    def new
      @theme = Theme.new
    end

    def create
      @theme = Theme.new(theme_params)
      @theme.save
      redirect_to admin_themes_url
    end

    def update
      @theme.update(theme_params)
      redirect_to admin_themes_url
    end

    def destroy
      @theme.destroy
    end

    private

    def set_theme
      @theme = Theme.find(params[:id])
    end

    def theme_params
      params.require(:theme).permit(:name, :image)
    end
  end
end
