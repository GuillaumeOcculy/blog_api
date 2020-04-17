class ProfileSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :slug
end
