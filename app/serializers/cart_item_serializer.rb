class CartItemSerializer
  include JSONAPI::Serializer
  attributes :id, :cart_id, :product_id, :quantity, :subtotal

  belongs_to :product
end
