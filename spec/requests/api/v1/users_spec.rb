require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
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

  path '/api/v1/users' do
    get 'List All users' do
      tags 'Users'
      produces 'application/json'
      response(200, 'successful') do
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test! do |response|
          let(:Authorization) { "Bearer #{auth_token}" }
          data = JSON.parse(response.body)
          expect(data).to be_an(Array)
        end
      end
    end

    post 'create user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name email password]
      }

      response(201, 'user created') do
        let(:user) { { name: 'John Doe', email: 'john.doe@example.com', password: 'password' } }
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:user) { { name: 'John Doe' } }
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    parameter name: 'id', in: :path, type: :integer, description: 'id'

    get('show user') do
      tags 'Users'
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 email: { type: :string }
               },
               required: %w[id name email]

        let(:id) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password').id }
        let(:Authorization) { "Bearer #{auth_token}" }
        run_test!
      end

      response(404, 'not found') do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch('update user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        }
      }

      response(200, 'user updated') do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:id) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password').id }
        let(:user) { { name: 'Jane Doe' } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:id) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password').id }
        let(:user) { { email: 'invalid' } }
        run_test!
      end
    end

    put('update user') do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response(200, 'user updated') do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:id) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password').id }
        let(:user) { { name: 'Jane Doe', email: 'jane.doe@example.com', password: 'newpassword' } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:id) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password').id }
        let(:user) { { email: 'invalid' } }
        run_test!
      end
    end

    delete('delete user') do
      tags 'Users'
      response(204, 'no content') do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:id) { User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password').id }
        run_test!
      end

      response(404, 'not found') do
        let(:Authorization) { "Bearer #{auth_token}" }
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
