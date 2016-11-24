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

    def getHTML(search)
      base1 = "https://pixabay.com/en/photos/?q="
      base2 = "&image_type=&cat=&min_width=&min_height="
      @full_url = base1 + search + base2

      @html = Nokogiri::HTML(open(@full_url)) do |config|
        config.strict.nonet
      end
      @html = @html.to_s
      return @html
    end

    def parse()
      @final = []
      numberArray = [1,5,7,13,17,19]
      @htmlpage = getHTML("cat")
      numberArray.each do |x|
        puts x
        @imgcluster = @htmlpage.split(/srcset="(.*?)">/)[x]
        i = @imgcluster.index(", ")
        j = @imgcluster.index(" 2x")
        @final += [@imgcluster[i+1..j-1]]
      end

      return @final

    end

    @finalArray = parse()

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
