class V1::BaseController < ApplicationController
  attr_reader :current_user

  before_action :set_default_format

  private

  def set_default_format
    request.format = :json
  end

  def authenticate_token!
    payload = JsonWebToken.decode(auth_token)
    @current_user = User.find(payload['sub'])
  rescue JWT::ExpiredSignature
    api_error(status: :unauthorized, errors: ['Auth token has expired'])
  rescue JWT::DecodeError
    api_error(status: :unauthorized, errors: ['Invalid auth token'])
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
  end

  def invalid_resource!(errors = [])
    api_error(status: 422, errors: errors)
  end

  def api_error(status: 500, errors: [])
    unless Rails.env.production?
      Rails.logger.error(errors.full_messages) if errors.respond_to? :full_messages
    end
    head status: status && return if errors.empty?

    render json: errors, status: status
  end
end
