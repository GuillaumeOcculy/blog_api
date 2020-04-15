class V1::FriendshipsController < V1::BaseController
  before_action :authenticate_token!
  before_action :find_friend, only: [:create]
  before_action :check_friend, only: [:create]
  before_action :find_friendship, only: [:accept, :decline]
  before_action :check_friendship, only: [:accept, :decline]

  def create
    current_user.send_friend_request(@find_friend)
    friendship = current_user.friendships.find_by(friend: @friend)
    render json: ::FriendshipSerializer.new(friendship), status: :created
  end

  def accept
    current_user.accept_friend_request(@friendship.id)
    @friendship.reload
    render json: ::FriendshipSerializer.new(@friendship, include: [:friend])
  end

  def decline
    current_user.decline_friend_request(@friendship.id)
    @friendship.reload
    render json: ::FriendshipSerializer.new(@friendship, include: [:friend])
  end

  private

  def find_friend
    @find_friend = User.find_by(slug: snakecase_params[:friend_id])
    @find_friend ||= User.find_by(id: snakecase_params[:friend_id])
  end

  def find_friendship
    @friendship = current_user.friendships.find_by(id: snakecase_params[:friendship_id])
  end

  def check_friend
    api_error(status: 404, errors: ['user not found']) unless @find_friend
  end

  def check_friendship
    api_error(status: 404, errors: ['friendship not found']) unless @friendship
  end
end
