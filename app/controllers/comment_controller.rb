class CommentController < ApplicationController
  before_action :authenticate_user!
  # @!method: someone comments on the image
  def create
    comment = Comment.new(comment_params)
    image = Image.find(params[:image_id])
    unless comment.save
      flash[:error] = "Comment was not saved!"
      redirect_to image # should go to the image detail view?
    end
    redirect_to image
  end

  def comment_params
    params.require :body
    params.require :user_id
    params.require :image_id
    params.permit(:body, :user_id, :image_id)
  end

end
