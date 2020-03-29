class V1::PostsController < V1::BaseController
  before_action :authenticate_token!

  def index
    posts = Post.all
    render json: ::PostSerializer.new(posts).serialized_json
  end

  def show
    post = Post.find(params[:id])
    render json: ::PostSerializer.new(post).serialized_json
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render json: ::PostSerializer.new(post).serialized_json, status: :created
    else
      invalid_resource!(post.errors)
    end
  end

  private

  def post_params
    params.permit(:body)
  end
end
