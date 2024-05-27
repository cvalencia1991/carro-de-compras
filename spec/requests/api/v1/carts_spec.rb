require 'swagger_helper'

RSpec.describe 'api/v1/carts', type: :request do

  path '/api/v1/carts/{id}' do
    get 'Cart' do
      tags 'Carts'
      produces 'application/json'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      security [bearerAuth: []]

      response(200, 'successful') do
        let(:id) { '1' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end

