require 'swagger_helper'

RSpec.describe 'Cart items', type: :request do
  let(:user) { create(:user) }
  let(:Authorization) { "Bearer #{user.generate_jwt}" }
  let(:cart) { create(:cart, user:) }
  let(:product) { create(:product) }

  before do
    login_as(user, scope: :user)
  end

  after do
    logout(:user)
  end

  path '/api/v1/cart_items' do
    post 'create Product' do
      consumes 'application/json'
      tags 'Cart Items'
      security [bearerAuth: []]
      parameter name: :cartitem, in: :body, schema: {
        type: :object,
        properties: {
          cart_id: { type: :integer },
          product_id: { type: :integer },
          quantity: { type: :integer }
        },
        required: %w[cart_id product_id quantity]
      }

      response '201', 'cart item created' do
        let(:cartitem) { { cart_id: cart.id, product_id: product.id, quantity: 2 } }
        run_test!
      end
    end
  end
end
