class MessageSerializer
  include FastJsonapi::ObjectSerializer
  attribute :body, :created_at

  attribute :messaged_by_current_user do |object, params|
    object.user == (params[:current_user])
  end

  belongs_to :user
end
