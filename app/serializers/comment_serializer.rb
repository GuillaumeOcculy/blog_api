class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body, :commentable_type, :commentable_id, :created_at

  belongs_to :user

  attribute :commented_by_current_user do |object, params|
    object.commented_by_user?(params[:current_user])
  end
end
