class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validate :product_in_stock

  before_save :adjust_product_stock
  before_destroy :restore_product_stock

  private

  def product_in_stock
    return unless quantity > product.stock

    errors.add(:quantity, 'is greater than available stock')
  end

  def adjust_product_stock
    quantity_diff = if persisted?
                      quantity - quantity_was
                    else
                      quantity
                    end
    product.update!(stock: product.stock - quantity_diff)
  end

  def restore_product_stock
    product.update!(stock: product.stock + quantity)
  end
end
