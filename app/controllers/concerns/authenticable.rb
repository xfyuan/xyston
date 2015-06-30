module Authenticable
  extend ActiveSupport::Concern

  def current_user
    authenticate_or_request_with_http_token do |token, options|
      @current_user ||= User.find_by(authentication_token: token)
    end
  end

  def authenticate_with_token
    render json: { errors: "Not authenticated" }, status: :unauthorized unless current_user.present?
  end
end
