class PostsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create,:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.new
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(
    :title,
    :content,
    )
  end
end
