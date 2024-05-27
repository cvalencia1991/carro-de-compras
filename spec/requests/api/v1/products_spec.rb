require 'swagger_helper'

RSpec.describe 'Product API', type: :request do
  let(:user) { create(:user) }
  let(:auth_token) do
    post user_session_path, params: { email: user.email, password: user.password }
    response.headers['Authorization'].split.last
  end

  before(:each) do
    # Authenticate Before Each Test
    sign_in(user)
  end

  after(:each) do
    # Log out for Each Test
    sign_out
  end


  path '/api/v1/products' do
    get 'get all products' do
      tags 'Products'
      produces 'application/json'
      security [bearerAuth: []]

      response '200', 'products found' do
        schema type: :object, properties: {
          status: { type: :integer },
          products: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                nombre: { type: :string },
                descripcion: { type: :string },
                tipo: { type: :string },
                precio: { type: :number, format: :float },
                stock: { type: :integer },
                created_at: { type: :string, format: :date_time },
                updated_at: { type: :string, format: :date_time }
              },
              required: %w[id nombre tipo precio stock]
            }
          }
        }

        let!(:products) { create_list(:product, 3) }
        let(:Authorization) { "Bearer #{auth_token}" }

        run_test!
      end
    end

    post 'create Product' do
      tags 'Products'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          product: {
            type: :object,
            properties: {
              nombre: { type: :string },
              descripcion: { type: :string },
              tipo: { type: :string },
              precio: { type: :number, format: :float },
              stock: { type: :integer }
            },
            required: %w[nombre tipo precio stock]
          }
        },
        required: [:product]
      }

      response '201', 'product created' do
        schema type: :object, properties: {
          id: { type: :integer },
          nombre: { type: :string },
          descripcion: { type: :string },
          tipo: { type: :string },
          precio: { type: :number, format: :float },
          stock: { type: :integer },
          created_at: { type: :string, format: :date_time },
          updated_at: { type: :string, format: :date_time }
        }
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:product) do
          { product: { nombre: 'Gafas de sol Carey', descripcion: 'algo para la vista', tipo: 'Producto', precio: 35.99,
                       stock: 10 } }
        end
        run_test!
      end

      response '400', 'bad request' do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:product) { { product: { descripcion: 'Proteccion visual' } } }
        run_test!
      end
    end
  end
end
