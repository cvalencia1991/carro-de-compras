class Product < ApplicationRecord
  # implemet to valid if is a product or a event
  VALID_TIPOS = %w[Producto Evento].freeze
  has_many :cart_items
  validates :tipo, presence: true,
                   inclusion: { in: VALID_TIPOS,
                                message: "%<value>s no es un tipo válido. Debe ser 'Producto' o 'Evento'." }
  validates :precio, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :descripcion, presence: true
  validates :stock, presence: true
end
