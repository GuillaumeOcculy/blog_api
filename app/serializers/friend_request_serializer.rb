class FriendRequestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :friend_id, :status

  belongs_to :friend, key: :user, serializer: UserSerializer
end
