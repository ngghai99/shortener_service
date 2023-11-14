module Api
  module Shortens
    class Create
      prepend SimpleCommand
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def call
        shorten = Shorten.find_or_initialize_by(original_url: params[:original_url])
        return ShortenPresenter.new(shorten).json_response if shorten.persisted?

        shorten.shortened_url = generate_shortened_url
        if shorten.save!
          ShortenPresenter.new(shorten).json_response
        end

        rescue StandardError => e
          errors.add(:errors, e)
      end

      private

      def generate_shortened_url
        characters = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a
        shortened_url = characters.sample(6).join

        while Shorten.exists?(shortened_url: shortened_url)
          shortened_url = characters.sample(6).join
        end

        shortened_url
      end
    end
  end
end
