require 'swagger_helper'

RSpec.describe 'api/v1/registrations', type: :request do
  path '/api/v1/sign_up' do
    post 'Creates a user' do
      tags 'Registration'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w[email password]
          }
        },
        required: ['user']
      }

      response '201', 'user created' do
        let(:user) { { user: { email: 'newuser@example.com', password: 'password' } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['token']).to be_present
          expect(data['user']['email']).to eq('newuser@example.com')
        end
      end

      response '422', 'invalid request' do
        let(:user) { { user: { email: 'newuser@example.com', password: '' } } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['errors']).to be_present
        end
      end
    end
  end
end
