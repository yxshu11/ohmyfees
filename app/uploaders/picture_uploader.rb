# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  # Cloudinary Support
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']

  version :standard do
    process :eager => true
    process :resize_to_fill => [140, 180, :north]
  end

  version :thumbnail do
    eager
    resize_to_fit(100, 100)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
