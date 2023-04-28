class Api::V1::BaseController < ApplicationController
  include JsonWebToken

  before_action :authenticate_user

  private

  def authenticate_user
    render_error('You are not authorized to perform this action. Please signin!', :unauthorized) unless current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: jwt_decode(token)['user_id'])
  end

  def token
    @token ||= request.headers['Authorization']&.split(' ')&.last
  end

  def render_error message, status
    render json: { error: message }, status: status
  end

  def render_resource resource, serializer, status, collection = false
    if collection
      render json: resource, each_serializer: serializer, status: status
    else
      render json: resource, serializer: serializer, status: status
    end
  end

  def render_access_token user_id, status
    access_token = jwt_encode({user_id: user_id})
    render json: { access_token: access_token }, status: status
  end
end
