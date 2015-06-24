module Authenticable
  extend ActiveSupport::Concern

  def current_user
    @current_user ||= User.find_by(authentication_token: request.headers['Authorization'])
  end

  def authenticate_with_token
    render json: { errors: "Not authenticated" }, status: :unauthorized unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end
end
