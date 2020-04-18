class V1::FriendsController < V1::BaseController
  before_action :authenticate_token!
  before_action :check_user

  def accept
    current_user.accept_friend_request(find_user)
    friendship = current_user.friendships.find_by(friend: find_user)

    render json: ::FriendshipSerializer.new(friendship, include: [:friend])
  end

  def decline
    current_user.decline_friend_request(find_user)
    friendship = current_user.friendships.find_by(friend: find_user)

    render json: ::FriendshipSerializer.new(friendship, include: [:friend])
  end

  private

  def find_user
    @find_user = User.find_by_slug(params[:friend_id])
  end

  def check_user
    api_error(status: 404, errors: ['user not found']) unless find_user
  end
end
