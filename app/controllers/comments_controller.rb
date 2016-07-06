class CommentsController < ApplicationController
  before_action :logged_in_user, :normal_user?

  def create
    @comment = Comment.new comment_params
    unless @comment.save
      flash[:danger] = t "flash.comment"
    end
    redirect_to :back
  end

  def destroy  
    @comment = current_user.comments.find params[:id]
    if @current_user.comments.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    end
    @comment.destroy
    redirect_to :back
  end

  private
  def comment_params
    params.require(:comment).permit :content, :user_id, :product_id
  end
end
