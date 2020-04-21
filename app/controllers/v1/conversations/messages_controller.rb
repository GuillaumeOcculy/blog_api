class V1::Conversations::MessagesController < V1::BaseController
  before_action :authenticate_token!
  before_action :check_conversation

  def index
    messages = find_conversation.messages.includes(:user)
    options = { include: [:user] }
    options[:params] = { current_user: current_user }

    render json: ::MessageSerializer.new(messages, options).serialized_json
  end

  def create
    message = find_conversation.messages.create(message_params.merge(user: current_user))
    render json: ::MessageSerializer.new(message, include: [:user]).serialized_json, status: :created
  end

  private

  def find_conversation
    @find_conversation ||= current_user.conversations.find_by(id: params[:conversation_id])
    @find_conversation ||= current_user.conversations.find_by(name: params[:conversation_id])
  end

  def check_conversation
    api_error(status: 404, errors: ['conversation not found']) unless find_conversation
  end

  def message_params
    params.permit(:body)
  end
end
