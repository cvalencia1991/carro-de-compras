FactoryBot.define do
  factory :cart_item do
    cart
    product
    quantity { 2 }
    price { product.price }

    after(:build) do |cart_item|
      cart_item.price = cart_item.product.price * cart_item.quantity
    end
  end
end
