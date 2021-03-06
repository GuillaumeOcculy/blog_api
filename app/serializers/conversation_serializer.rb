class ConversationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  has_many :messages
  has_many :users
end
