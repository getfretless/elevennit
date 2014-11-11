class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :link, :body))
    if @post.save
      redirect_to posts_path, flash: { notice: 'It worked' }
    else
      flash.now[:error] = 'You broke it. Nice going.'
      render :new
    end
  end

end
