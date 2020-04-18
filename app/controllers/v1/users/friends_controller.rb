class V1::Users::FriendsController < V1::BaseController
  before_action :authenticate_token!, only: [:create]
  before_action :check_user

  def index
    render json: ::UserSerializer.new(find_user.friends).serialized_json
  end

  private

  def find_user
    @find_user = User.find_by_slug(params[:user_id])
  end

  def check_user
    api_error(status: 404, errors: ['user not found']) unless find_user
  end
end
