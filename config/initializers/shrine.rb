require "shrine"
require "shrine/storage/s3"
require "shrine/storage/memory"
require "shrine/storage/file_system"

if Rails.env.test?
  Shrine.storages[:store] = Shrine::Storage::Memory.new
elsif Rails.env.development?
  Shrine.storages = {
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),
  }
else
  s3_options = {
    bucket: ENV['AWS_BUCKET'],
    region: ENV['AWS_REGION'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  }

  Shrine.storages = {
    store: Shrine::Storage::S3.new(public: true, prefix: 'uploads/posts', **s3_options)
  }
end

Shrine.plugin :activerecord
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :derivatives
Shrine.plugin :model, cache: false
