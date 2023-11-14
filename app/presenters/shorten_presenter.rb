class ShortenPresenter < SimpleDelegator

  def json_response
    {
      shortened_url: Rails.application.routes.url_helpers.shortened_url(shortened_url, host: ENV["APP_HOST"])
    }
  end
end
