class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  include ApplicationConcern
  include Error::ErrorHandler

  private

  def authenticate_request
    @current_user = AuthorizeRequest.call(request.headers).result
    render json: { data: { message: 'Not authorized' } }, status: 401 unless @current_user
  end
end
