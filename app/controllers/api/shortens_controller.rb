class Api::ShortensController < ApplicationController
  before_action :set_shorten, only: [:show]

  def show
    redirect_to @shorten.original_url, allow_other_host: true
  end

  def create
    @shorten = Shorten.new(original_url: params[:original_url])
    @shorten.shortened_url = SecureRandom.hex(6)

    if @shorten.save
      render json: { shortened_url: shortened_url_url(@shorten.shortened_url) }
    else
      render json: { error: @shorten.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_shorten
    @shorten = Shorten.find_by(shortened_url: params[:short_url])
    unless @shorten
      render json: { error: 'Shortened URL not found' }, status: :not_found
    end
  end
end
