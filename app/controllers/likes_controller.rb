class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(post: @post)

    if @like.save
      redirect_to user_post_path(@post.author, @post), notice: 'Post liked!'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unable to like post!'
    end
  end
end
