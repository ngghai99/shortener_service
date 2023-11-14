module Api
  class Authenticate
    prepend SimpleCommand
    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      user = User.find_by(email: email)

      unless user&.authenticate(password)
        errors.add(:error, "Please check your Email or Password.")
        return nil
      end

      payload = { user_id: user.id }
      token = JwtTokenable.generate_jwt_token(payload)
      response_data = { user: UserPresenter.new(user).json_response, auth_token: token }
      return response_data
    end
  end
end
