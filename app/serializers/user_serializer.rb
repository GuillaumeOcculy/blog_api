class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :slug

  attribute :current_user_friendship_status do |object, params|
    return unless params[:current_user]

    params[:current_user].friendships.find_by(friend: object)&.status
  end

  has_many :posts
  has_many :friends, record_type: :user
end
