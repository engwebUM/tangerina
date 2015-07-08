class CommentsController < ApplicationController
  before_action :set_article_comment, only: [:edit, :update, :destroy]

  def index
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id if current_user
    if @comment.save
      redirect_to article_path(@article.article_review)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_user?
      format_update
    else
      redirect_to article_path(@article.article_review)
    end
  end

  def destroy
    @comment.destroy if current_user?
    redirect_to article_path(@article.article_review)
  end

  private

  def format_update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @article.article_review }
      else
        format.html { render 'edit' }
      end
      format.json { render json: @article.article_review }
    end
  end

  def current_user?
    @comment.user_id == current_user.id
  end

  def set_article_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
