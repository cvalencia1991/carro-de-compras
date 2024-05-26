require 'swagger_helper'

RSpec.describe 'Product API', type: :request do
  let(:user) { create(:user) }
  let(:auth_token) { authenticate_user(user) }

  path '/api/v1/products' do
    get 'get all products' do
      tags 'Products'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'products found' do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            nombre: { type: :string },
            descripcion: { type: :string },
            tipo: { type: :string },
            precio: { type: :number, format: :float },
            stock: { type: :integer }
          },
          required: %w[id nombre tipo precio]
        }

        let!(:products) { create_list(:product, 3) }
        let(:Authorization) { "Bearer #{auth_token}" }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:Authorization) { 'Bearer invalid_token' }
        run_test!
      end
    end
  end

  # path '/api/v1/products' do
  #   post 'create Product' do
  #     tags 'products'
  #     consumes 'application/json'
  #     security [bearerAuth: []]
  #     parameter name: :product, in: :body, schema: {
  #       type: :object,
  #       properties:{
  #         "nombre" => {type: :string},
  #         "descripcion" => {type: :string},
  #         "tipo" => {type: :string},
  #         "precio" => { type: :number, format: :float},
  #         "stock" => { type: :integer}
  #       },
  #       required:  ["nombre", "tipo", "precio"]
  #     }

  #     response '201', 'product created' do
  #       schema type: :object,
  #       properties: {
  #         nombre: { type: :integer },
  #         tipo: { type: :string  },
  #         precio: { type: :string, 'x-nullable': true } ,
  #         stock: { type: :integer}
  #       }
  #       let(:product){ { "nombre" => "Gafas de sol Carey", "tipo" => "Producto", "precio" => 35.99, "stock" => 10}}
  #       run_test!
  #     end

  #     response '400', 'Invalid Request' do
  #       let(:product){ { "description" => "Proteccion visual" }}
  #       run_test!
  #     end
  #   end
  # end
end
