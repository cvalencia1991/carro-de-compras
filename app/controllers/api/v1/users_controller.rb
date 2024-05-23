class  Api::V1::UsersController < ApplicationController

    # GET /api/v1/users
    def index
        users = User.all
        render json: users, status: :ok
      end

    # GET /api/v1/users/:id
    def show
      user = User.find(params[:id])
      render json: user, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
    end

    # POST /api/v1/users
    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end

    # PATCH /api/v1/users/:id
    def update
      user = User.find(params[:id])
      if user.update(user_params)
        render json: user, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
    end

    # DELETE /api/v1/users/:id
    def destroy
      user = User.find(params[:id])
      user.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :not_found
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :name) # Adjust permitted params as needed
    end
  end