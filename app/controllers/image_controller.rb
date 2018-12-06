class ImageController < ApplicationController
  def show
    @image = Image.find(params[:id])
    @user = User.find(@image.user_id)
  end
end
