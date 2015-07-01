class Api::ProductsController < ApplicationController
  before_action :authenticate_with_token
  before_action :set_product,        only: [:show]
  before_action :set_authed_product, only: [:update, :destroy]

  def index
    @products = Product.search(params).page(params[:page]).per(params[:per_page])
    render json: @products, meta: pagination(@products, params[:per_page])
  end

  def show
    render json: @product
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: 200
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_authed_product
      @product = current_user.products.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :price, :published, :quantity)
    end
end
