class LoginController < ApplicationController
  skip_before_action :authenticate_request

  def login
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      api(token: command.result)
    else
      status_code_401
    end
  end
end
