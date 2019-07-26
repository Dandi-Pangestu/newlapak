module Error::ErrorHandler
  def self.included(clazz)
    # clazz.class_eval do
    #   rescue_from Exception, with: :status_code_500
    #   rescue_from ActionController::RoutingError, with: :status_code_404
    #   rescue_from ActiveRecord::RecordNotFound, with: :status_code_404
    # end
  end
end