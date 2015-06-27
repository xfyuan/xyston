class Api::OrdersController < ApplicationController
  include Authenticable

  before_action :set_order,             only: [:show]
  before_action :set_authed_order,      only: [:update, :destroy]
  before_action :authenticate_with_token

  def index
    render json: current_user.orders
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Product.find(params[:id])
    end

    def set_authed_order
      @order = current_user.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:title, :price, :published)
    end
end
