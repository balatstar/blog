class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments, :author).paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html { render }
      format.json { render json: @posts, except: %i[created_at updated_at] }
    end
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:error] = 'Error saving post.'
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    if @post.destroy
      redirect_to user_path(@user), notice: 'Post was successfully deleted.'
    else
      flash[:error] = 'Error deleting post.'
      redirect_to user_post_path(@user, @post)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
