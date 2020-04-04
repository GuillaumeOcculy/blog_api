class V1::PostsController < V1::BaseController
  before_action :authenticate_token!, only: [:create]

  def index
    posts = Post.includes(:user, likes: :user).recent
    render json: ::PostSerializer.new(posts, include: [:user, :'likes.user']).serialized_json
  end

  def show
    post = Post.find(params[:id])
    render json: ::PostSerializer.new(post, include: [:user, :'likes.user']).serialized_json
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: ::PostSerializer.new(post, include: [:user, :'likes.user']).serialized_json, status: :created
    else
      invalid_resource!(post.errors)
    end
  end

  private

  def post_params
    params.permit(:body)
  end
end
