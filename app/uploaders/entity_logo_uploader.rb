# encoding: utf-8
class EntityLogoUploader < CarrierWave::Uploader::Base
  def store_dir
    "#{Rails.root.join('public')}public/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
