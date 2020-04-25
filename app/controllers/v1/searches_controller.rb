class V1::SearchesController < V1::BaseController
  def index
    users = User.search params[:q]
    render json: ::UserSerializer.new(users)
  end
end
