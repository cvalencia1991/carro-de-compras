module AuthenticationHelper
  def authenticate_user(user)
    post '/api/v1/sign_in', params: { email: user.email, password: user.password }
    JSON.parse(response.body)['token']
  end
end
