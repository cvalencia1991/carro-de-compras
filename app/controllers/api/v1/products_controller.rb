class Api::V1::ProductsController < ApplicationController

  # Get all the products in with Stock
  def index
    products = Product.all
    render json: products, status: :ok
  end

  # Create new Product
  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :created
    else
      render json:{status: 400, error:"invalid request"}, status: :bad_request
    end
  end

  private

  def product_params
    params.require(:product).permit(:nombre, :precio, :tipo, :descripcion, :stock)
  end
end
