class ApplicationController < ActionController::API
    before_action :authenticate_user!
    # use Rescue Form to put some errors more simples when you send a bad request or a not found API
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

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

end
