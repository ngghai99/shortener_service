class UserPresenter < SimpleDelegator
  def json_response
    {
      id: id,
      email: email,
      first_name: first_name,
      last_name: last_name
    }
  end
end
