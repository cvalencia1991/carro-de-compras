Rails.application.routes.draw do
  # Create documentation for the API using Rswag gem
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users

  # set Configuration to development the graphQl
  mount GraphiQL::Rails::Engine, at: '/api/v1/graphiql', graphql_path: 'graphql#execute' if Rails.env.development?


  # the health stablish to test if the server is up
  get 'up' => 'rails/health#show', as: :rails_health_check

  # create api/v1/... routes
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :cart_items, only: %i[create update destroy show]
      resources :users
      resources :products, only: %i[create index]
      resources :current_user, only: %i[index]
      resources :carts, only: %i[show update destroy]
      # make this scope to create the sign_up and sign_in inside of the api
      post '/graphql', to: 'graphql#execute'
      devise_scope :user do
        post 'sign_in', to: 'sessions#create'
        post 'sign_up', to: 'registrations#create'
        delete 'sign_out', to: 'sessions#destroy'
      end
    end
  end
end
