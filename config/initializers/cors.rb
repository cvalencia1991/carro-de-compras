Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins "*"  # Change this with the domain of Front end Or Framework and the
      resource "*", #  resources for the routes that are avaible to use
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        expose: [:Authorization]
    end
  end