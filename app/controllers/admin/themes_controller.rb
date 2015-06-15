module Admin
  class ThemesController < AdminController
    before_action :set_theme, only: :destroy
    before_filter :require_login, :authorize

    def index
      @themes = Theme.all
      @theme = Theme.new
    end

    def create
      @theme = Theme.new(theme_params)
      if @theme.save
        flash[:notice] = 'Theme was successfully created'
      else
        flash[:error] = 'Please try again!'
      end
      redirect_to admin_themes_url
    end

    def destroy
      @theme.destroy
      flash[:notice] = 'Theme was successfully destroyed'
      redirect_to admin_themes_url
      # respond_to do |format|
      # format.html { redirect_to themes_url }
      # format.json { head :no_content }
      # end
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
