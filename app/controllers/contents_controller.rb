class ContentsController < ApplicationController
  before_action :set_content, only: :destroy

  def new
    @content = Content.new
  end

  def create
    @content = Content.create(content_params)
    if @content.save
      render json: { message: 'success' }, status: 200
    else
      render json: { error: @content.errors.full_messages.join(',') }, status: 400
    end
  end

  def update
    redirect_to @content.article_review if @content.update(content_params)
  end

  def destroy
    if @content.destroy
      render json: { message: 'File deleted from server' }
    else
      render json: { message: @upload.erros.full_messagens.join(',') }
    end
  end

  private

  def set_content
    @content = Content.find(params[:id])
  end

  def content_params
    params.require(:content).permit(:file)
  end
end
