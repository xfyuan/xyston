class Api::SessionsController < ApplicationController
  before_action :set_user, only: [:create]

  # POST /api/sessions
  # POST /api/sessions.json
  def create
    if @user && @user.authenticate(user_params[:password])
      update_authentication_token @user
      render json: Api::SessionSerializer.new(@user, root: false).to_json, status: 200
    else
      render json: { errors: 'Invalid email or password' }, status: :unauthorized
    end
  end

  # DELETE /api/sessions/1
  # DELETE /api/sessions/1.json
  def destroy
    user = User.find_by(authentication_token: params[:id])
    update_authentication_token user
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(email: user_params[:email])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def update_authentication_token(user)
      user.generate_authentication_token
      user.update_attribute(:authentication_token, user.authentication_token)
      user.reload
    end
end
