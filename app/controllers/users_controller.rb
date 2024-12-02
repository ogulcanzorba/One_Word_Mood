class UsersController < ApplicationController
  before_action :authenticate_user! # Devise ile oturum doğrulama

  def profile
    @user = current_user # Giriş yapan kullanıcıyı alır
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(4)
    @total_views=0

  end
  private
  def set_user
    @user = User.find(params[:id])
  end
end

