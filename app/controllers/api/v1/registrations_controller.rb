# class Registrations Controller
class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  # Response the registration for the user if its correct or not
  def respond_with(resource, _opts = {})
    if resource.persisted?
      headers['Authorization'] = current_token
      Cart.create(user_id: resource.id)
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      # response an error if not could create
      render json: {
        code: 422,
        message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end
end
