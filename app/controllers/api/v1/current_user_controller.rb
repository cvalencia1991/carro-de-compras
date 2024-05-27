class Api::V1::CurrentUserController < ApplicationController
  # Get Current User After Sign in
  def index
    render json: {
      user: current_user.as_json(except: :jti)
    }, status: :ok
  end
end
