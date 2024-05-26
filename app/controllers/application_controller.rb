class ApplicationController < ActionController::API
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # use Rescue Form to put some errors more simples when you send a bad request or a not found API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::ParameterMissing, with: :render_bad_request
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  rescue_from ActionController::RoutingError, with: :render_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end

  private

  def render_not_found
    render json: { error: 'Not found' }, status: :not_found
  end

  def render_bad_request
    render json: { error: 'Bad request' }, status: :bad_request
  end

  def unprocessable_entity(e)
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def route_not_found
    render json: { error: 'Routing error: No route matches the requested URL' }, status: :not_found
  end
end
