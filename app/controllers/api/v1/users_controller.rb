class Api::V1::UsersController < ApplicationController
  # GET /api/v1/users
  def index
    users = User.all
    render json: { status: 200, users: }, status: :ok
  end

  # GET /api/v1/users/:id
  def show
    user = User.find_by(id: params[:id])
    if user
      render json: { status: 200, user: }, status: :ok
    else
      render json: { status: 404, error: 'User not found' }, status: :not_found
    end
  end

  # POST /api/v1/users
  def create
    user = User.new(user_params)
    if user.save
      render json: { status: 201, user: }, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/users/:id
  def update
    user = User.find_by(id: params[:id])
    if user
      if user.update(user_params)
        render json: { status: 200, user: }, status: :ok
      else
        render json: { errors: user.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  # DELETE /api/v1/users/:id
  def destroy
    user = User.find_by(id: params[:id])
    if user
      user.destroy
      render json: { status: 200, message: 'User deleted successfully' }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  private

  # Require parameters when sending to the API
  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
