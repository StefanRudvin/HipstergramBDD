class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!
  before_action :owned_post, only: [:edit, :update, :destroy]
  before_action :loggedin

  def unlike
  if @post.unliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def like
  if @post.liked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def index
    @posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
  end

  def browse
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash[:alert] = "Your new post couldn't be created!  Please check the form."
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated hombre"
      redirect_to post_path
    else
      flash.now[:alert] = "Something is wrong with your form!"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Problem solved!  Post deleted.'
    redirect_to posts_path
  end

  def edit
  end

  private

  def loggedin
    @loggedin = current_user
  end

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

end
