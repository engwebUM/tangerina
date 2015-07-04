class CommentsController < ApplicationController
  # before_action :set_article_comment, only: [:show, :edit, :update, :destroy]

  def index
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id if current_user
    if @comment.save
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.user_id == current_user.id
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @article }
          format.json { render json: @article }
        else
          format.html { render 'edit' }
          format.json { render json: @article }
        end
      end
    else
      redirect_to article_path(@article)
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      redirect_to article_path(@article)
    end
  end

  private

  def set_article_comment
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
