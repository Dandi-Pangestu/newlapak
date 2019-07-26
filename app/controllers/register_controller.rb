class RegisterController < ApplicationController
  skip_before_action :authenticate_request

  def register
    if !User.find_by_email(register_params[:email]).nil?
      api({ message: 'Email already exists' }, 422)
    else
      @user = User.new(register_params)
      if @user.save
        api(token: JsonWebToken.encode(user_id: @user.id))
      else
        api(@user.errors, 400)
      end
    end
  end

  private

  def register_params
    params.require(:user).permit(:name, :email, :password)
  end
end
