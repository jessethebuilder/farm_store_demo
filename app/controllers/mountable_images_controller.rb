class MountableImagesController < ApplicationController
  before_action :set_mountable_image

  def destroy
    @mountable_image.destroy
  end

  private

  def set_mountable_image
    @mountable_image = MountableImage.find(params[:id])
  end
end