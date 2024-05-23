class Api::V1::CartItemsController < ApplicationController
  before_action :set_cart

  def create
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if quantity <= 0
      render json: { error: 'Quantity must be greater than zero.' },
             status: :unprocessable_entity
      return
    end

    cart_item = @cart.cart_items.find_or_initialize_by(product_id: product.id)
    cart_item.quantity += quantity
    cart_item.price = product.price

    if cart_item.save
      render json: cart_item, status: :created
    else
      render json: cart_item.errors, status: :unprocessable_entity
    end
  end

  def update
    cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity.negative?
      render json: { error: 'Quantity cannot be negative.' }, status: :unprocessable_entity
    elsif new_quantity.zero?
      destroy_cart_item(cart_item)
    elsif new_quantity > cart_item.product.stock + cart_item.quantity
      render json: { error: 'Not enough stock available.' }, status: :unprocessable_entity
    else
      cart_item.quantity = new_quantity
      if cart_item.save
        render json: cart_item
      else
        render json: cart_item.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    cart_item = @cart.cart_items.find(params[:id])
    destroy_cart_item(cart_item)
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def destroy_cart_item(cart_item)
    cart_item.destroy
    render json: { message: 'Cart item deleted successfully.' }, status: :ok
  end
end
