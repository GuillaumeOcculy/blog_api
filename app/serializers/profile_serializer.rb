class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username

  attribute :current_user_friendship_status do |object, params|
    if params && params[:current_user]
      params[:current_user].friendships.find_by(friend: object)&.status
    end
  end
end
