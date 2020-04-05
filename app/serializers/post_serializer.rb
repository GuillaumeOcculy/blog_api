class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :created_at

  belongs_to :user
  has_many :likes
end
