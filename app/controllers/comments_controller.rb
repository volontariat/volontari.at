class CommentsController < ApplicationController
  load_and_authorize_resource
  
  respond_to :html, :js, :json
  
  def index
    @comments = Comment.includes(:commentable, :user).all
  end
  
  def show
    @comment = Comment.includes(:commentable, :user).find(params[:id])
  end
  
  def new
    @comment = Comment.new(params[:comment])
    commentable = commentable = @comment.commentable ? @comment.commentable : find_parent(Comment::COMMENTABLE_TYPES)
    eval("@#{commentable.class.name.tableize.singularize} = commentable")
    @vacancy = commentable.vacancy if commentable.is_a?(Candidature)
    @comment.commentable = commentable
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to @comment.commentable, notice: t('comments.show.successfully_created')
    else
      render :new
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    
    if @comment.update_attributes(params[:comment])
      redirect_to @comment, notice: t('comments.show.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_url, notice: t('comments.show.destroyed')
  end
end