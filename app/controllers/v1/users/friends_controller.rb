class V1::Users::FriendsController < V1::BaseController
  before_action :authenticate_token!, only: [:create]
  before_action :check_user

  def index
    friendships = find_user.friendships.where(status: [:accepted, :requested])
    render json: ::FriendshipSerializer.new(friendships, include: [:friend]).serialized_json
  end

  def create
    current_user.send_friend_request(find_user)
    friendship = current_user.friendships.find_by(friend: find_user)

    render json: ::FriendshipSerializer.new(friendship, include: [:friend]), status: :created
  end

  private

  def find_user
    @find_user = User.find_by_slug(params[:user_id])
  end

  def check_user
    api_error(status: 404, errors: ['user not found']) unless find_user
  end
end
