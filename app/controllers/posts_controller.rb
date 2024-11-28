class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:user).all
    @post = Post.new
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

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user # Assign the current user to the post

    if @post.save
      redirect_to @post, notice: 'Post successfully created.'
    else
      render :index # Render the index view so the form and posts list are visible
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

  # Ensure the user is logged in
  def authenticate_user!
    # Replace with real authentication logic, e.g., using Devise
    unless current_user
      redirect_to root_path, alert: "You must be logged in to perform this action."
    end
  end

  # Simulate current_user method for development/testing
  def current_user
    # Replace with actual logic for retrieving the logged-in user
    User.first
  end

  # Permit the necessary parameters
  def post_params
    params.require(:post).permit(:content, :mood_word)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
