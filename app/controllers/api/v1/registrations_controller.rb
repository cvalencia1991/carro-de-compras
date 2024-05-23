class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.new(sign_up_params)
    if user.save
      cart = user.build_cart
      if cart.save
        render json: { message: 'Signed up successfully.', user: user.as_json(except: :jti) }, status: :ok
      else
        user.destroy
        render json: { message: 'Sign up failed.', errors: cart.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Sign up failed.', errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def respond_with(resource, _opts = {})
    if request.method == "DELETE"
      # Handle DELETE request (if needed)
    elsif request.method == "POST" && resource.persisted?
      render json: {
        user: resource.as_json(except: :jti)
      }, status: :ok
    else
      super
    end
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
