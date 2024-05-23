class Cart < ApplicationRecord
  belongs_to :user
  has_many :products
  has_many :cart_items, dependent: :destroy

  def total
    cart_items.to_a.sum(&:total_price)
  end
end
