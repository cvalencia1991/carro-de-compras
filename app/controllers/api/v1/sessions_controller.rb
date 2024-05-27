class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :authenticate_user!, only: [:create]
  # Create Sission
  def create
    user_params = params.require(:user).permit(:email, :password)
    user = User.find_by(email: user_params[:email])
    # If User is Valid logged in Sucessfully
    if user&.valid_password?(user_params[:password])
      sign_in(user)
      render json: {
        status: 200,
        message: 'Logged in successfully.',
        user: UserSerializer.new(user).serializable_hash[:data][:attributes],
        token: current_token
      }, status: :ok
    else
      # Invalid password or Email
      render json: {
        status: 400,
        messages: ['Invalid Email or Password.']
      }, status: :bad_request
    end
  end
end
