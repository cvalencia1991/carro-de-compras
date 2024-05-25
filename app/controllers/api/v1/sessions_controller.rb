class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  def destroy
    super
  end

  private

  def respond_to_on_destroy
    if current_user.nil?
      render json: { message: "Logged out successfully" }, status: :ok
    else
      render json: { message: "Unable to log out" }, status: :unprocessable_entity
    end
  end

  def respond_with(resource, _opts = {})
    if resource
      render json: {
        user: current_user.as_json(except: [:jti, :created_at, :updated_at, :id])
      }, status: :ok
    else
      render json: { messages: ["Invalid Email or Password."] }, status: :unprocessable_entity
    end
  end
end
