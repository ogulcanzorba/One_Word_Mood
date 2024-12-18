class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit_avatar, :update_avatar, :edit_handle, :update_handle, :edit, :update]

  
  def profile
    @user = current_user
    @own_posts = current_user.posts.order(created_at: :desc)
    @liked_posts = Post.joins(:likes).where(likes: { user_id: current_user.id }).order(created_at: :desc)
    @saved_posts = current_user.saved_posts.map(&:post) # Get associated posts through saved_posts
  end

  def edit
    # This will render the edit form for user information (e.g., email, password)
  end

  def update
    if @user.update(user_params)
      redirect_to profile_users_path, notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  def edit_avatar
  end

  def update_avatar
    if @user.update(user_params)
      redirect_to profile_users_path, notice: "Profile picture updated successfully."
    else
      render :edit_avatar
    end
  end

  def edit_handle
  end

  def update_handle
    if @user.update(user_params)
      redirect_to profile_users_path, notice: "Handle updated successfully."
    else
      render :edit_handle
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:avatar, :handle, :email, :password) # Add other fields you want to update
  end
end
# user.rb (Model dosyası)
class User < ApplicationRecord
  has_many :followers, class_name: "Follow", foreign_key: "followed_id"
  has_many :followings, class_name: "Follow", foreign_key: "follower_id"

  def followers_count
    followers.count
  end

  def following_count
    followings.count
  end
end

def show
  @user = User.find(params[:id])
  @own_posts = @user.posts
  @saved_posts = @user.saved_posts
end
