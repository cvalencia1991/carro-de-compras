class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  #Make Authenticate true to sign out
  def destroy
    @authenticated = true
    super
  end

  private

  # verify user if is in the current user has the session active
  def verify_signed_out_user
    current_user
    super
  end

  def respond_to_on_destroy
    if @authenticated && current_user.nil?
      # current_user is logged out successfully
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      # current_user is not logged out successfully
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  def respond_with(resource, _opts = {})
    if resource
      # User is logged in successfully
      token = request.env['warden-jwt_auth.token']
      response.headers['Authorization'] = "Bearer #{token}"
      render json: {
        status: 200,
        message: 'Logged in successfully.',
        user: UserSerializer.new(resource).serializable_hash[:data][:attributes], # Use `user` instead of `resource`
        token:
      }, status: :ok
    else
      # current_user is not logged in successfully
      render json: {
        messages: ['Invalid Email or Password.']
      }, status: :unprocessable_entity
    end
  end
end
