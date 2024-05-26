Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # later change to the domain of the frontend app
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: [:Authorization]
  end
end
