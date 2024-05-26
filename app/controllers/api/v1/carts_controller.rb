class Api::V1::CartsController < ApplicationController
  before_action :set_cart, only: %i[show update destroy]

  # GET /carts/:id
  def show
    render json: CartSerializer.new(@cart, include: [:cart_items]).serializable_hash.to_json
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end
end
