class ProfileController < ApplicationController
  before_action :authenticate_request

  def show
    api(serializer(@current_user, UserSerializer))
  end

end
