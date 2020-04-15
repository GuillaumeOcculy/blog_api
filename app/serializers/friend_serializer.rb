class FriendSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name, :slug
end
