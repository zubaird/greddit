class CommentsController < ApplicationController

  def new
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find_by(id: params[:id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end


end

private

def comment_params
  params.require(:comment).permit(
  :body,
  :post_id,
  )
end

end
