class UsersController < ApplicationController
  before_action :authenticate_user! # Devise ile oturum doğrulama

  def profile
    @user = current_user # Giriş yapan kullanıcıyı alır
    @posts = @user.posts
    @total_views=0

  end
  private
  def set_user
    @user = User.find(params[:id])
  end
end

