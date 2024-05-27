class Api::V1::CartItemsController < ApplicationController
  before_action :set_cart, only: %i[create update destroy]

  def show
    cart_item = CartItem.find_by(cart_id:params[:id])
    if cart_item
      render json: { status:200, cart_item: }, status: :ok
    else
      render json: { status:400, message: "not found"}, status: :not_found
    end
  end

  # Create the item in the cart
  def create
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i
    # Check if the quantity is valid
    unless quantity.positive?
      render json: { error: 'Quantity must be greater than zero.' }, status: :unprocessable_entity
      return
    end

    # Find or initialize the cart item
    cart_item = @cart.cart_items.find_or_initialize_by(product_id: product.id)

    # Initialize quantity to 0 if it's a new record
    cart_item.quantity ||= 0

    # Update quantity and price
    cart_item.update(quantity: cart_item.quantity + quantity)

    # if cart item Saved Sucessfully
    if cart_item.save
      render json: { status: 200, message: "Cart item added successfully", cart_item: cart_item }, status: :created
    else
      render json: { status: 404, error: cart_item.errors }, status: :unprocessable_entity
    end
  end

  # Update the cart item inside of the Cart
  def update
    cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    # the quantity of the cart items can't be negative or bigger than the stock
    if new_quantity.negative?
      render json: { error: 'Quantity cannot be negative.' }, status: :unprocessable_entity
    elsif new_quantity.zero?
      destroy_cart_item(cart_item)
      render json: { status:200, message: "item delete for the cart"}, status: :ok
    elsif new_quantity > cart_item.product.stock + cart_item.quantity
      render json: { status: 422, error: 'Not enough stock available.' }, status: :unprocessable_entity
    else
      cart_item.quantity = new_quantity
      if cart_item.save
        render json: { status: 200, message: "cart item updated successfully", cart_item: cart_item }
      else
        render json: { status: 404, message: cart_item.errors }, status: :unprocessable_entity
      end
    end
  end

  # Destroy the Cart Item
  def destroy
    cart_item = @cart.cart_items.find(params[:id])
    destroy_cart_item(cart_item)
  end

  private
  # Set The cart
  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  # Destroy the item in the Cart Item
  def destroy_cart_item(cart_item)
    cart_item.destroy
    render json: { status: 200, message: 'Cart item deleted successfully.' }, status: :ok
  end
end
