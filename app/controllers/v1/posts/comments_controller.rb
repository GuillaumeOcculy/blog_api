class V1::Posts::CommentsController < V1::BaseController
  before_action :authenticate_token!, only: [:create]

  before_action :find_post
  before_action :check_post

  def index
    comments = @post.comments.includes(:user, :commentable)
    options = { include: [:user] }
    options[:params] = { current_user: current_user }

    render json: ::CommentSerializer.new(comments, options).serialized_json
  end

  def create
    comment = @post.comments.build(user_id: current_user.id, body: params[:body])
    if comment.save
      options = { include: [:user] }
      options[:params] = { current_user: current_user }

      render json: ::PostSerializer.new(@post, options).serialized_json, status: :created
    else
      invalid_resource!(comment.errors)
    end
  end

  def destroy
    @post.comments.find(params[:id]).destroy
    render json: ::PostSerializer.new(@post, include: [:user], params: { current_user: current_user }).serialized_json
  end

  private

  def find_post
    @post = Post.find_by(id: params[:post_id])
  end

  def check_post
    api_error(status: 404, errors: ['post not found']) unless @post
  end
end
