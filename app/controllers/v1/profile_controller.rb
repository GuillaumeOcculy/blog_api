class V1::ProfileController < V1::BaseController
  def show
    render json: ::ProfileSerializer.new(current_user).serialized_json
  end
end
