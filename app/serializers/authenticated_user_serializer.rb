class AuthenticatedUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :token
end
