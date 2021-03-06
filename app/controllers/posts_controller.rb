class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :save]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.with_categories.with_user.includes(:comment_threads).page(params[:page])
  end

  def show
    @comment = Comment.build_from @post, current_user.id, ''
  end

  def edit
  end

  def new
    @post = Post.new
    @post.post_type = params[:post_type] if params[:post_type].present?
  end

  def create
    @post = Post.new post_params
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, flash: { notice: 'It worked' }
    else
      flash.now[:error] = @post.errors.full_messages
      render :new
    end
  end

  def save
    ElevenNote.create_from @post, current_user.elevennote_api_key
    redirect_to @post, notice: 'Saved to ElevenNote!'
  rescue
    redirect_to @post, alert: 'We were unable to save that to ElevenNote.'
  end

  def update
    if @post.update post_params
      redirect_to post_path(@post), flash: { notice: 'Updated!' }
    else
      flash.now[:error] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, flash: { notice: 'Your post has been removed.' }
    else
      redirect_to posts_path, flash: { notice: 'We were unable to remove that post.' }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :link, :body, :post_type, :category_id)
  end

  def find_post
    @post = Post.find params[:id]
  end

end
