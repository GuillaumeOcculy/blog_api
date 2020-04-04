class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :created_at

  belongs_to :user, record_type: :creator
  has_many :likes
end
