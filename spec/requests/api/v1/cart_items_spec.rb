require 'swagger_helper'

RSpec.describe 'Cart Items API', type: :request do
  let(:user) { create(:user) }
  let(:auth_token) do
    post user_session_path, params: { email: user.email, password: user.password }
    response.headers['Authorization'].split(' ').last
  end
  let(:cart) { create(:cart, user: user) }
  let(:product) { create(:product) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product) }

  before(:each) do
    # Authenticate Before Each Test
    sign_in(user)
  end

  after(:each) do
    # Log out for Each Test
    sign_out
  end

  path '/api/v1/cart_items/{id}' do
    # SHOW /api/v1/cart_items/{id}
    get 'get all the cart items by cart id' do
      tags 'Cart Items'
      produces 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'carts items found' do
        schema type: :object,
          properties: {
            status: { type: :integer },
            cart_item: {
              type: :object,
              properties: {
                id: { type: :integer },
                cart_id: { type: :integer },
                product_id: { type: :integer },
                quantity: { type: :integer }
              },
              required: %w[id cart_id product_id quantity]
            }
          }

        let(:id) { cart_item.id }
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test!
      end

      response '404', 'cart items not found' do
        schema type: :object,
          properties: {
            status: { type: :integer },
            message: { type: :string }
          },
          required: %w[status message]

        let(:id) { 'invalid' }
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test!
      end
    end

    put 'update a cart item' do
      tags 'Cart Items'
      consumes 'application/json'
      security [bearerAuth: []]
      parameter name: :id, in: :path, type: :integer # Corregir el tipo de parámetro a :integer
      parameter name: :cart_item, in: :body, schema: {
        type: :object,
        properties: {
          cart_id: {type: :integer},
          quantity: { type: :integer }
        },
        required: [:quantity]
      }
      response '200', 'cart item updated' do
        let(:id) { cart_item.id }
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:cart_item) { { quantity: 3 } } # Nueva cantidad
        run_test!
      end

      response '404', 'cart item not found' do
        let(:id) { 'invalid' }
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:cart_item) { { quantity: 3 } }
        run_test!
      end
    end

    # DELETE /api/v1/cart_items/{id}
    delete 'delete a cart item' do
      tags 'Cart Items'
      security [bearerAuth: []]
      parameter name: :id, in: :path, type: :integer # Corregir el tipo de parámetro a :integer
      response '200', 'cart item deleted' do
        let(:id) { cart_item.id }
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test!
      end
      response '404', 'cart item not found' do
        let(:id) { 'invalid' }
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test!
      end
    end
  end
end
