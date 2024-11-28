class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end


  def show
    @post = Post.find(params[:id])
  end


  def new
    @post = Post.new
  end


  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to @post, notice: 'Post successfully created.'
    else
      render :new
    end
  end


  def edit
    @post = Post.find(params[:id])
  end


  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post, notice: 'Post successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end


  def set_post
    @post = Post.find(params[:id])
  end
end
