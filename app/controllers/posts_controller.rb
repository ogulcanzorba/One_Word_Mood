class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:user).all
    @post = Post.new # Initialize a new post for the form
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(4)  # En yeni olan en üstte
    # Logs a warning if no posts are found
    Rails.logger.warn("No posts found") if @posts.empty?
  end

  def show
    @post = Post.find_by(id: params[:id])

    if @post.nil?
      redirect_to posts_path, alert: "Post not found."
    elsif @post.user.nil?
      flash[:alert] = "This post does not have an associated user."
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user # Assign the current user to the post

    if @post.save
      redirect_to posts_path, notice: 'Post successfully created.' # Redirect to index to display posts
    else
      @posts = Post.all
      render :index # If validation fails, show the index with the form again
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:mood_word)
  end
end
