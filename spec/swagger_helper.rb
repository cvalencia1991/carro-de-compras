require 'rails_helper'

RSpec.configure do |config|
  # Specify the root folder where the Swagger JSON files are generated
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  config.openapi_specs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1 Shopping Cart',
        version: 'v1',
        descripcion: 'This is Api for Cart Shop commerce',
        contact: {
          name: 'API Cart Shop',
          email: 'cesar4a6z@gmail.com'

        },
        license: 'MIT',
        url: ''
      },
      paths: {
        '/api/v1/products': {
          get: {
            summary: 'List all products',
            tags: ['Products'],
            responses: {
              '200': {
                description: 'List of products',
                content: {
                  'application/json': {
                    schema: {
                      type: :array,
                      items: {
                        '$ref': '#/components/schemas/Product'
                      }
                    }
                  }
                }
              }
            }
          },
          post: {
            summary: 'Create a new product',
            tags: ['Products'],
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    '$ref': '#/components/schemas/Product'
                  }
                }
              }
            },
            responses: {
              '201': {
                description: 'Product created'
              },
              '422': {
                description: 'Unprocessable entity'
              }
            }
          }
        },
        '/api/v1/sign_up': {
          post: {
            summary: 'Creates a user',
            tags: ['Registration'],
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    '$ref': '#/components/schemas/SignUp'
                  }
                }
              }
            },
            responses: {
              '201': {
                description: 'User created',
                content: {
                  'application/json': {
                    schema: {
                      '$ref': '#/components/schemas/User'
                    }
                  }
                }
              },
              '422': {
                description: 'Unprocessable entity'
              }
            }
          }
        },
        '/api/v1/sign_in': {
          post: {
            summary: 'Authenticates a user',
            tags: ['Session'],
            requestBody: {
              required: true,
              content: {
                'application/json': {
                  schema: {
                    '$ref': '#/components/schemas/SignIn'
                  }
                }
              }
            },
            responses: {
              '200': {
                description: 'User authenticated',
                content: {
                  'application/json': {
                    schema: {
                      type: :object,
                      properties: {
                        status: { type: :integer },
                        message: { type: :string },
                        user: {
                          id: { type: :integer },
                          email: { type: :string },
                          created_at: { type: :string }
                        },
                        token: { type: :string }
                      }
                    }
                  }
                }
              },
              '401': {
                description: 'Invalid credentials'
              }
            }
          }
        }
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      components: {
        schemas: {
          Product: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              price: { type: :number, format: :float }
            },
            required: %w[name price]
          },
          User: {
            type: :object,
            properties: {
              id: { type: :integer },
              email: { type: :string },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            }
          },
          SignIn: {
            type: :object,
            properties: {
              User: {
              type: :object,
              properties: {
              email: { type: :string },
              password: { type: :string }
              }
            }
          },
            required: %w[email password]
          },
          SignUp: {
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
            }
          },
          cart: {
            properties: {
              id: { type: :integer },
              },
            required: %w[id]
          },
          Cart_items: {
              type: :object,
              properties: {
                id: { type: :integer },
                cart_id: { type: :integer },
                quantity: { type: :integer },
              },
            required: %w[cart_id quantity]
          }
        },
        securitySchemes: {
          bearerAuth: {
            type: :http,
            scheme: :bearer,
            bearerFormat: :JWT,
            description: 'Bearer token authentication'
          }
        }
      },
      security: [
        { bearerAuth: [] }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  config.openapi_format = :json
end
