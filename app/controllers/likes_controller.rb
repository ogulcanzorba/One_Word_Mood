class LikesController < ApplicationController
  before_action :authenticate_user!

  def same_mood
    @post = Post.find(params[:post_id])

    # Check if the user has already expressed the same mood
    if @post.likes.exists?(user: current_user)
      flash[:alert] = "You have already expressed the same mood."
    else
      # Create a new like record
      current_user.likes.create(post: @post)
      flash[:notice] = "You expressed the same mood!"
    end

    redirect_to root_path
  end

  def undo_same_mood
    @post = Post.find(params[:id])
    like = @post.likes.find_by(user: current_user)

    if like
      like.destroy
      flash[:notice] = "You have undone the same mood!"
    else
      flash[:alert] = "You haven't expressed the same mood on this post yet."
    end

    redirect_to root_path
  end



  def remove_mood
    @post = Post.find(params[:post_id])

    # Find and remove the existing "Same Mood" expression
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
      flash[:notice] = "You removed your mood expression."
    else
      flash[:alert] = "You haven't expressed this mood yet."
    end

    redirect_to root_path
  end
end
