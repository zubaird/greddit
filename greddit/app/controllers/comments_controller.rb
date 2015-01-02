class CommentsController < ApplicationController

  before_action :authenticate_user, only: [:create,:destroy]

  def new
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find_by(id: params[:id])
    @comment = @post.comments.new(comment_params)
    if @comment.save && @comment.update(user_id: current_user.id)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = Post.find_by(id: params[:post_id])
    if @comment.destroy
      redirect_to post_path(@post), notice: "comment deleted successfully"
    end
  end

private

def comment_params
  params.require(:comment).permit(
  :body,
  :post_id,
  :user_id,
  )
end

end
