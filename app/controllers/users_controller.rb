class UsersController < ApplicationController
  before_action :authenticate_user! # Devise ile oturum doğrulama

  def profile
    @user = current_user
    @own_posts = current_user.posts.order(created_at: :desc)
    @liked_posts = Post.joins(:likes).where(likes: { user_id: current_user.id }).order(created_at: :desc)
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated successfully."
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar,:name, :email, :password, :password_confirmation)
  end
end

