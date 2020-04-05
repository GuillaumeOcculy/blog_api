class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :created_at

  link :self do |object|
    "/posts/#{object.id}"
  end

  belongs_to :user
  has_many :likes, links: {
    related: -> (object) {
      "/posts/#{object.id}/likes"
    }
  }
end
