class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user, only: [
    :update,
    :edit,
    :edit_avatar,
    :update_avatar,
    :edit_handle,
    :update_handle,
    :follow,
    :unfollow
  ]

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
    if params[:search].present?
      @users = User.where("handle LIKE ?", "%#{params[:search]}%")
    else
      @users = User.all
    end
  end


  def show
    @user = User.find(params[:id])
    @own_posts = @user.posts.order(created_at:  :desc)
    @liked_posts = Post.joins(:likes).where(likes: { user_id: @user.id }).order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_avatar
  end

  def update_avatar
    if @user.update(user_params)
      redirect_to profile_users_path
    else
      render :edit_avatar
    end
  end

  def edit_handle
  end

  def update_handle
    if @user.update(user_params)
      redirect_to profile_users_path
    else
      render :edit_handle
    end
  end

  def follow
    @user = User.find(params[:id])
    if current_user.follow(@user)
      flash[:notice]="Now you're following #{@user.handle}!"
      redirect_to users_path
    else
      flash[:alert] = "Unable to follow #{@user.handle}."
      redirect_to users_path
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    flash[:notice]="You unfollowed #{@user.handle}"
    redirect_to users_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(
      :avatar,
      :handle,
      :email,
      :password,
      :password_confirmation
    )
  end
end
