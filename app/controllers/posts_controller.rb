class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy, :same_mood, :undo_same_mood]


  def index
    @post = Post.new # For the new post form
    @posts = Post.includes(:user).order(updated_at: :desc).page(params[:page]).per(4)
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
      @posts = Post.page(params[:page]).per(4) # Adjust number per page as needed
      render :index # If validation fails, show the index with the form again
    end
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      redirect_to posts_path, alert: "You are not authorized to edit this post."
    end
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      redirect_to posts_path, alert: "You are not authorized to edit this post."
    elsif @post.update(post_params)
      redirect_to posts_path, notice: "Post successfully updated."
    else
      flash.now[:alert] = "Failed to update the post. Please fix the errors below."
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find_by(id: params[:id]) # Restrict deletion to the post owner

    if @post
      @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted.'
    else
      redirect_to posts_path, alert: 'You are not authorized to delete this post.'
    end
  end

  def same_mood
    like = @post.likes.find_by(user: current_user)

    if like
      like.destroy
      flash[:notice] = "You removed your mood expression!"
    else
      @post.likes.create(user: current_user)
      flash[:notice] = "You expressed the same mood!"
    end

    redirect_to posts_path
  end

  def undo_same_mood
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
      flash[:notice] = "You have undone the same mood!"
    else
      flash[:alert] = "You haven't expressed the same mood on this post yet."
    end
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:mood_word, :content)
  end
end
