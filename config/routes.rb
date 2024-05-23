Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users



  # set Configuration to development the graphQl
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: 'graphql#execute' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'

  # the health stablish to test if the server is up
  get 'up' => 'rails/health#show', as: :rails_health_check

  # create api/v1/... routes
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :cartitem, only: %i[create update destroy]
      resources :users
      resources :products, only: [:create, :index]
      resources :current_user, only:[:index]

      devise_scope :user do
        post 'sign_in', to: 'sessions#create'
        post 'sign_up', to: 'registrations#create'
        delete 'sign_out', to: 'sessions#destroy'
      end
    end
  end
end
