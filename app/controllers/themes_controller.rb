class ThemesController < ApplicationController
  before_action :require_login, :set_theme, only: [:destroy]

  # GET /themes
  # GET /themes.json
  def index
    @themes = Theme.all
    @theme = Theme.new
  end

  # POST /themes
  # POST /themes.json
  def create
    @theme = Theme.new(theme_params)

    respond_to do |format|
      if @theme.save
        format.html { redirect_to action: :index }
        format.json { render action: :index, location: @themes }
        format.js { render inline: 'location.reload( );' }
      else
        format.html { render :new }
        format.json { render json: @theme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /themes/1
  # DELETE /themes/1.json
  def destroy
    @theme.destroy
    respond_to do |format|
      format.html { redirect_to themes_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_theme
    @theme = Theme.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def theme_params
    params.require(:theme).permit(:name)
  end
end
