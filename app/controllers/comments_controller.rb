class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments, except: %i(created_at updated_at)
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to user_post_path(user_id: @comment.post.author_id, id: @comment.post_id)
    else
      flash.now[:error] = 'Error saving comment.'
      render 'new'
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def destroy
    @comment.destroy
    redirect_to user_post_path(@comment.post.author, @comment.post), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
