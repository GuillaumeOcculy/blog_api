class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username

  link :self do |object|
    "/users/#{object.username}"
  end

  attribute :current_user_friendship_status do |object, params|
    if params && params[:current_user]
      params[:current_user].friendships.find_by(friend: object)&.status
    end
  end
end
