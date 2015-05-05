class ThemesController < ApplicationController
  before_action :require_login, :set_theme, only: [:destroy]

  def index
    @themes = Theme.all
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      #redirect_to action: :index
      index
    else
      render :new
    end
  end

  def destroy
    @theme.destroy
    redirect_to themes_url
    #respond_to do |format|
    #  format.html { redirect_to themes_url }
    #  format.json { head :no_content }
    #end
  end

  private

  def set_theme
    @theme = Theme.find(params[:id])
  end

  def theme_params
    params.require(:theme).permit(:name)
  end
end
