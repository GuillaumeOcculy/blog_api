class FriendSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :slug
end
