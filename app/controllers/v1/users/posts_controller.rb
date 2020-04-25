class V1::Users::PostsController < V1::BaseController
  before_action :check_user, only: [:index]

  def index
    render json: ::PostSerializer.new(find_user.posts, include: [:user]).serialized_json
  end

  private

  def find_user
    @find_user = User.find_by_slug(params[:user_id])
  end

  def check_user
    api_error(status: 404, errors: ['user not found']) unless find_user
  end
end
