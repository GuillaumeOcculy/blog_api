class V1::Users::FriendsController < V1::BaseController
  before_action :authenticate_token!, only: [:destroy]
  before_action :check_user, only: [:index]
  before_action :check_friend, only: [:destroy]

  def index
    render json: ::UserSerializer.new(find_user.friends, params: { current_user: current_user }).serialized_json
  end

  def destroy
    current_user.unfriend(find_friend)
    render json: ::UserSerializer.new(current_user.friends).serialized_json
  end

  private

  def find_user
    @find_user = User.find_by_slug(params[:user_id])
  end

  def find_friend
    @find_friend = User.find_by_slug(params[:id])
  end

  def check_user
    api_error(status: 404, errors: ['user not found']) unless find_user
  end

  def check_friend
    api_error(status: 404, errors: ['friend not found']) unless find_friend
  end
end
