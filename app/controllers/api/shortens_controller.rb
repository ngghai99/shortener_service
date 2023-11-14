class Api::ShortensController < ApplicationController
  before_action :set_shorten, only: [:show]

  def show
    redirect_to @shorten.original_url, allow_other_host: true
  end

  def create
    render_unauthorized('Token invalid') and return unless current_user
    command = Api::Shortens::Create.call(params)
    if command.success?
      render json: command.result
    else
      render json: { errors: command.errors[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def set_shorten
    @shorten = Shorten.find_by(shortened_url: params[:short_url])
    unless @shorten
      render html: "<strong>The Page you're looking for doesn't exist.</strong>".html_safe
    end
  end
end
