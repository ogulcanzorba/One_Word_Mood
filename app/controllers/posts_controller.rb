class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :edit, :update, :destroy, :same_mood, :undo_same_mood ]

  def index
    @post = Post.new
    @posts = Post.includes(:user).order(updated_at: :desc).page(params[:page]).per(4)
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      redirect_to posts_path
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      @posts = Post.page(params[:page]).per(4)
      render :index
    end
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      redirect_to posts_path
    end
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      redirect_to posts_path
    elsif @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      @post.destroy
      redirect_to posts_path
    else
      redirect_to posts_path
    end
  end

  def same_mood
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
    else
      @post.likes.create(user: current_user)
    end
    redirect_to posts_path
  end

  def undo_same_mood
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
    end
    redirect_to posts_path
  end

  def followed_posts
    following_users = current_user.following
    @posts = Post.where(user: following_users).order(created_at: :desc)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:mood_word, :content, :gif_url)
  end
end
