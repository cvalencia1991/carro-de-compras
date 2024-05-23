class Product < ApplicationRecord
  # implemet to valid if is a product or a event
  VALID_TIPOS = %w[Producto Evento].freeze
  has_many :cart_items
  validates :tipo,
            inclusion: { in: VALID_TIPOS,
                         message: "%<value>s no es un tipo válido. Debe ser 'producto' o 'evento'." }
  validates :precio, numericality: { greater_than_or_equal_to: 0 }
end
