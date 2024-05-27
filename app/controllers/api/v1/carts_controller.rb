class Api::V1::CartsController < ApplicationController
  # GET /api/v1/carts/:id
  def show
    cart = Cart.includes(:cart_items).find(params[:id])
    if cart
      render json: { status: 200, total: cart.total, cart_items: cart.cart_items }, status: :ok
    else
      render json: { status: 404, message: 'not found' }, status: :not_found
    end
  end
end
