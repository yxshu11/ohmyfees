# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base
  # Cloudinary Support
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']

  version :standard do
    process :eager => true
    cloudinary_transformation :radius => :max, :border=>"2px_solid_grey",
                              :crop => :thumb, :gravity => :face,
                              :width => 150, :height => 150
  end

  version :thumbnail do
    eager
    cloudinary_transformation :radius => :max, :border=>"1px_solid_grey",
                              :crop => :thumb, :gravity => :face,
                              :width => 100, :height => 100
  end
end
