class CommentsController < ApplicationController
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

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end