class Api::ProductsController < ApplicationController

  before_action :set_product, only: [:show]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_authed_product
      @product = current_product
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :price, :published, :user_id)
    end
end
