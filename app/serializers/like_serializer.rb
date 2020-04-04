class LikeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :likeable_type, :likeable_id

  belongs_to :user
end
