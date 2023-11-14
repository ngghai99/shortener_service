class UserPresenter < SimpleDelegator
  def json_response
    {
      id: id,
      email: email,
      role: role,
      first_name: first_name,
      last_name: last_name
    }
  end
end
