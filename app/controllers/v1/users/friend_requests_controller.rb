class V1::Users::FriendRequestsController < V1::BaseController
  before_action :authenticate_token!, only: [:create]
  before_action :check_user, only: [:index, :show]
  before_action :check_friend, only: [:accept, :decline]

  def index
    requested_friends = []
    requested_friends = find_user.requested_friends if current_user&.id == find_user.id

    render json: ::UserSerializer.new(requested_friends).serialized_json
  end

  def create
    current_user.send_friend_request(find_user)
    friendship = current_user.friendships.find_by(friend: find_user)

    render json: ::FriendshipSerializer.new(friendship, include: [:friend]), status: :created
  end

  def accept
    current_user.accept_friend_request(find_friend)

    render json: ::UserSerializer.new(current_user.requested_friends).serialized_json
  end

  def decline
    current_user.decline_friend_request(find_friend)

    render json: ::UserSerializer.new(current_user.requested_friends).serialized_json
  end

  private

  def find_user
    @find_user = User.find_by_slug(params[:user_id])
  end

  def find_friend
    @find_friend = User.find_by_slug(params[:friend_request_id])
  end

  def check_user
    api_error(status: 404, errors: ['user not found']) unless find_user
  end

  def check_friend
    api_error(status: 404, errors: ['friend not found']) unless find_friend
  end
end
