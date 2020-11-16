# frozen_string_literal: true
# https://medium.com/better-programming/build-a-rails-api-with-jwt-61fb8a52d833
#
require 'concerns/jwt_helper'

class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    JwtHelper.encode(payload, Time.now.to_i + 30.minutes)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JwtHelper.decode(token)
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
