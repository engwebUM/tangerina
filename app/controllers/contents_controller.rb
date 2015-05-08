class ContentsController < ApplicationController
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

  private

  def content_params
    params.require(:content).permit(:file)
  end
end
