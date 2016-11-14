class PostsController < ApplicationController
  
  before_action :set_post, only: [:show, :edit, :update, :destroy]  
  before_action :authenticate_user!
  #before_action :loggedin
  
  def index
    @posts = Post.all
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

end
