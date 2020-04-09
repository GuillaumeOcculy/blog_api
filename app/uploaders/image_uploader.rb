require 'image_processing/mini_magick'
class ImageUploader < Shrine
  Attacher.validate do
    validate_max_size 1 * 1024 * 1024
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]
    validate_extension %w[jpg jpeg png webp tiff tif]
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(1200, 1200),
      medium: magick.resize_to_limit!(800, 800),
      small: magick.resize_to_limit!(400, 400)
    }
  end
end
