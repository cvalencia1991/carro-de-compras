FROM ruby:3.3.1

ENV RUBY_VERSION 3.3.1

# Run Dependencies from Ubuntu
RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    bash \
    libxml2-dev \
    libxslt-dev \
    tzdata \
    openssl \
    --no-install-recommends \
    && apt-get clean

# Set the working directory
WORKDIR /app

# search gem files
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Set the main script to run when the container starts
ENTRYPOINT ["bin/rails"]

# Default command to run the Rails server
# Remember it runs the server but not the port depend of the command of docker that handle it the localport
CMD [ "server","-b", "0.0.0.0"]
