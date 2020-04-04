class V1::Posts::LikesController < V1::BaseController
  before_action :authenticate_token!
  before_action :find_post
  before_action :check_post

  def create
    @post.likes.find_or_create_by(user_id: current_user.id)
    render json: ::PostSerializer.new(@post, include: [:user, :likes]).serialized_json, status: :created
  end

  def destroy
    @post.likes.where(user_id: current_user.id).destroy_all
    render json: ::PostSerializer.new(@post, include: [:user]).serialized_json
  end

  private

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end

  def check_post
    api_error(status: 404, errors: ['post not found']) unless @post
  end
end
