class V1::Users::MessagesController < V1::BaseController
  before_action :authenticate_token!

  def create
    user_ids = friend_ids.ids + [current_user.id]
    users = User.where(id: user_ids)
    return api_error(status: 422, errors: ['You must enter a friend\'s username']) if users.size < 2

    conversation = Conversation.find_by_users(users)
    message = conversation.messages.create(message_params.merge(user: current_user))

    render json: ::MessageSerializer.new(message).serialized_json, status: :created
  end

  private

  def friend_ids
    friend_usernames = snakecase_params[:friend_usernames].collect(&:strip)
    current_user.friends.where(username: friend_usernames)
  end

  def message_params
    params.permit(:body)
  end
end
