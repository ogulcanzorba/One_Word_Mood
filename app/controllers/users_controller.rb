class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :follow, :unfollow]

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

  def follow
    current_user.follow(@user)
    redirect_to users_path, notice: "You are now following #{@user.email}."
  end

  def unfollow
    @user = User.find(params[:id]) # Takipten çıkılacak kullanıcıyı bul
    if current_user.unfollow(@user) # Modeldeki `unfollow` metodu çağrılır
      redirect_to users_path, notice: "You have unfollowed #{@user.email}."
    else
      redirect_to users_path, alert: "Failed to unfollow the user."
    end
  end


  private

  def set_user
    Rails.logger.debug "PARAMS[:id]: #{params[:id]}"
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :handle, :email, :password)
  end
end

def delete
  @user = User.find(params[:id])
  current_user.unfollow(@user)
  redirect_to users_path, notice: "You have unfollowed #{@user.email}."
end
