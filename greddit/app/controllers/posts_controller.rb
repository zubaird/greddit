class PostsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create,:destroy, :edit, :update]

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

  def edit
    @post = current_user.posts.find_by(id: params[:id])
    if !@post
      redirect_to post_path(params[:id]), notice: "You can't edit that!"
    end
  end

  def update
    @post = current_user.posts.find_by(id:params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: "Update Successful"
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
    :id,
    )
  end



end
