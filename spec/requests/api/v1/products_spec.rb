require 'swagger_helper'

RSpec.describe 'Product API', type: :request do
  let(:user) { create(:user) }
  let(:Authorization) { "Bearer #{user.generate_jwt}" }

  before do
    login_as(user, scope: :user)
  end

  # If you want to logout admin
  after do
    logout(:user)
  end

  path '/api/v1/products' do
    post 'Create Product' do
      tags 'Products'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties:{
          "nombre" => {type: :string},
          "description" => {type: :string},
          "tipo" => {type: :string},
          "precio" => { type: :number, format: :float},
          "stock" => { type: :integer}
        },
        required:  ["nombre", "tipo", "precio"]
      }

      response '201', 'product created' do
        let(:product){ { "nombre" => "Gafas de sol Carey", "tipo" => "Producto", "precio" => 35.99, "stock" => 10}}
        run_test!
      end

      response '400', 'Invalid Request' do
        let(:product){ { "description" => "Proteccion visual" }}
        run_test!
      end
    end
  end
end

