class AuthenticatedUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :slug, :token
end
