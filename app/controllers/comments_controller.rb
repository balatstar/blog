class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments, except: %i[created_at updated_at]
  end

  def create
    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    @post = Post.find(params[:comment][:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    respond_to do |format|
      if @comment.save
        format.html { redirect_to user_post_path(user_id: @comment.post.author_id, id: @comment.post_id) }
        format.json { render json: @comment, status: :created, location: user_post_comment_path(current_user, @post, @comment) }
      else
        flash.now[:error] = 'Error saving comment.'
        format.html { render 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
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
