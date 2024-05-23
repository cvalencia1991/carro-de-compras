class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    user = User.find_for_database_authentication(email: params[:user][:email])
    if user&.valid_password?(params[:user][:password])
      sign_in(user)
      respond_with(user)
    else
      render json: { message: 'Invalid email or password.' }, status: :unauthorized
    end
  end

  def destroy
    sign_out(current_user)
    render json: { message: 'Logged out successfully.' }, status: :ok
  end

  private

  def respond_with(resource, _opts = {})
    if current_user
      render json: {
        user: current_user.as_json(except: :jti)
      }, status: :ok
    else
      render json: { message: 'User not authenticated.' }, status: :unauthorized
    end
  end
end
