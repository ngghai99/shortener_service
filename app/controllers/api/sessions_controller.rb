class Api::SessionsController < ApplicationController
  def create
    command = Api::Authenticate.call(params[:email], params[:password])
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors[:error] }, status: :unauthorized
    end
  end
end
