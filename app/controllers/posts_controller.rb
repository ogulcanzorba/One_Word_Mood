class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:like, :edit, :update, :destroy]
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
      # Paginate posts when rendering the index view
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

  def like
    @post = Post.find(params[:id])

    # Kullanıcı daha önce beğenmişse, aynı postu tekrar beğenmesini engelle
    unless @post.likes.exists?(user: current_user)
      @post.likes.create(user: current_user)
      flash[:notice] = "Post successfully liked!"
    else
      flash[:alert] = "You have already liked this post."
    end


    redirect_to posts_path
  end
  def unlike
    def unlike
      @post = Post.find(params[:id])

      like = @post.likes.find_by(user: current_user)
      if like
        like.destroy
        flash[:notice] = "You unliked the post."
      else
        flash[:alert] = "You haven't liked this post yet."
      end

      redirect_to posts_path
    end
  end



  private

  def post_params
    params.require(:post).permit(:mood_word)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
