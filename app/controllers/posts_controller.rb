class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :destroy]  
  before_action :authenticate_user!
  
  def index
    @posts = Post.all
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:success] = "Post updated hombre"
      redirect_to posts_path
    else
      flash.now[:alert] = "Something is wrong with your form!"
      render :edit
    end
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = "Your post has been created."
      redirect_to @post
    else
      flash[:alert] = 'Halt, you fiend! You need an image to post here!'
      render :new
    end
    
  end

  def new
    @post = Post.new
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'Problem solved!  Post deleted.'
    redirect_to posts_path
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end
  
  def set_post
    @post = Post.find(params[:id])
  end

end
