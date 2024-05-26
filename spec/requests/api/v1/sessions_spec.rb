require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  path '/api/v1/sign_in' do
    post 'Authenticates a user' do
      tags 'Session'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'user authenticated' do
        let(:user) { create(:user, email: 'existinguser@example.com', password: 'password') }
        let(:credentials) { { email: user.email, password: 'password' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['token']).to be_present
          expect(data['user']['email']).to eq(user.email)
        end
      end

      response '401', 'invalid credentials' do
        let(:credentials) { { email: 'nonexistent@example.com', password: 'wrongpassword' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['messages']).to include('Invalid Email or Password.')
        end
      end
    end
  end
end
