class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to(user_post_path(@comment.user_id, @comment.post_id))
    else
      flash[:error] = @comment.errors.full_messages
      redirect_to(user_post_path(@comment.user_id, @comment.post_id))
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end
end
