class CartSerializer
  include JSONAPI::Serializer
  attributes :id, :total
  has_many :cart_items
end
