class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, only: [ :update, :edit, :edit_avatar, :update_avatar, :edit_handle, :update_handle, :follow, :unfollow ]

  def set_current_user
    @user = current_user
  end
  def profile
    @user = current_user
    @own_posts = @user.posts.order(created_at: :desc)
    @liked_posts = Post.joins(:likes).where(likes: { user_id: @user.id }).order(created_at: :desc)
    @saved_posts = @user.saved_posts
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @own_posts = @user.posts
    @saved_posts = @user.saved_posts
  end

  def edit
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

  def follow
    @user = User.find(params[:id])
    if current_user.follow(@user)
      redirect_to users_path, notice: "You are now following #{@user.handle}."
    else
      redirect_to users_path, alert: "Unable to follow this user."
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to users_path, notice: "You have unfollowed this user."
  end
end



  private

  def set_user
    if params[:id]
      @user = User.find_by(id: params[:id])
    else
      @user = current_user
    end
    unless @user
      redirect_to users_path, alert: "User not found."
    end
  end


  def user_params
    params.require(:user).permit(:avatar, :handle, :email, :password)
  end


def delete
  @user = User.find(params[:id])
  current_user.unfollow(@user)
  redirect_to users_path, notice: "You have unfollowed #{@user.email}."
end
