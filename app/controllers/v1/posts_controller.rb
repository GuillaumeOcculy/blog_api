class V1::PostsController < V1::BaseController
  before_action :authenticate_token!, only: [:create]

  def index
    posts = Post.includes(:user).recent
    render json: ::PostSerializer.new(posts, include: [:user], params: { current_user: current_user }).serialized_json
  end

  def show
    post = Post.find(params[:id])
    return api_error(status: 404, errors: ['post not found']) unless post

    render json: ::PostSerializer.new(post, include: [:user], params: { current_user: current_user }).serialized_json
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: ::PostSerializer.new(post, include: [:user]).serialized_json, status: :created
    else
      invalid_resource!(post.errors)
    end
  end

  private

  def post_params
    params.permit(:body, :image)
  end
end
