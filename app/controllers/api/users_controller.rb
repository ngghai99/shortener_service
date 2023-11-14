class Api::UsersController < ApplicationController
  def create
    command = Api::Users::Create.call(user_params)

    if command.success?
      render json:command.result
    else
      render json: command.errors, status: :unprocessable_entity
    end
   end

  private

  def user_params
    params.permit(:email, :password, :first_name, :last_name)
  end
end
