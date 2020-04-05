class PostSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :created_at

  link :self do |object|
    "/posts/#{object.id}"
  end

  attribute :liked_by_current_user do |object, params|
    object.liked_by_user?(params[:current_user])
  end

  belongs_to :user
  has_many :likes, links: {
    related: ->(object) {
      "/posts/#{object.id}/likes"
    }
  }

  has_many :comments, links: {
    related: ->(object) {
      "/posts/#{object.id}/comments"
    }
  }
end
