module Api
  module Users
    class Create
      prepend SimpleCommand
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def call
        user = User.new(params)

        if user.save!
          UserPresenter.new(user).json_response
        end

        rescue StandardError => e
          errors.add(:errors, e)
      end
    end
  end
end
