class Api::OrdersController < ApplicationController
  include Authenticable

  before_action :set_authed_order,      only: [:show, :update, :destroy]
  before_action :authenticate_with_token

  def index
    render json: current_user.orders
  end

  def show
    render json: @order
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_authed_order
      @order = current_user.orders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:product_ids => [])
    end
end
