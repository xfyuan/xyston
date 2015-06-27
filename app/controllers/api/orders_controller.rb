class Api::OrdersController < ApplicationController
  include Authenticable

  before_action :set_authed_order,      only: [:show, :update, :destroy]
  before_action :authenticate_with_token

  def index
    @orders = current_user.orders.page(params[:page]).per(params[:per_page])
    render json: @orders, meta: { pagination: {
      per_page: params[:per_page],
      total_pages: @orders.total_pages,
      total_objects: @orders.total_count
    } }
  end

  def show
    render json: @order
  end

  def create
    @order = current_user.orders.build
    @order.build_placements_with_product_ids_and_quantities(params[:order][:product_ids_and_quantities])

    if @order.save
      @order.reload
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

end
