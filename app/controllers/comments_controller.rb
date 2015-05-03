class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    # respond_to do |format|
    if @comment.save
      redirect_to :back
      # respond_with :show, location: @comment
      # format.html { redirect_to :back, notice: 'Comment was successfully created.' }
      # format.json { render :show, status: :created, location: @comment }
      # format.js { render inline: 'location.reload();' }
    else
      # format.html { render :new }
      # format.json { render json: @comment.errors, status: :unprocessable_entity }
      redirect_to :back
    end
    # end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:article_id, :user_id, :body)
  end
end
