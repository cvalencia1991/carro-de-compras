class CartItem < ApplicationRecord
  include CartItemConcern
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :product_in_stock
end
