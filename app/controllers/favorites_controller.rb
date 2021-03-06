class FavoritesController < ApplicationController
  before_action :set_favorite, only: :destroy

  def index
  end

  def create
    @favorite = Favorite.new
    @article = Article.find(params[:article_id])
    @favorite.user_id = current_user.id
    @favorite.article_id = @article.id
    if @favorite.save
      redirect_to :back, notice: 'Favorite was successfully created.'
    else
      redirect_to :back
    end
  end

  def destroy
    @favorite.destroy
    redirect_to :back
    # respond_to do |format|
    #   format.html { redirect_to :back, notice: 'Favorite was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def favorite_params
    params.require(:favorite).permit(:article_id, :user_id)
  end
end
