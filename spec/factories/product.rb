FactoryBot.define do
  factory :product do
    nombre { 'Producto de prueba' }
    descripcion { 'Descripción del producto de prueba' }
    tipo { 'Producto' }
    precio { 9.99 }
    stock { 10 }
  end
end
