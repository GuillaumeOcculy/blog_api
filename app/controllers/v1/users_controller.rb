class V1::UsersController < V1::BaseController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.friendly.find(params[:id])
    options = { params: { current_user: current_user } }

    render json: ::UserSerializer.new(user, options)
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: ::AuthenticatedUserSerializer.new(user).serialized_json, status: :created
    else
      invalid_resource!(user.errors)
    end
  end

  private

  def user_params
    snakecase_params.permit(:username, :password)
  end
end
