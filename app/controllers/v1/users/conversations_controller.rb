class V1::Users::ConversationsController < V1::BaseController
  before_action :authenticate_token!

  def index
    conversations = current_user.conversations
    render json: ::ConversationSerializer.new(conversations).serialized_json
  end

  def show
    conversation = current_user.conversations.find(params[:id])
    render json: ::ConversationSerializer.new(conversation, include: [:users, :messages]).serialized_json
  end
end
