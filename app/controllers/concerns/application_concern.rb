module ApplicationConcern

  def status_code_400
    api({ message: 'Bad Request' }, 400)
  end

  def status_code_401
    api({ message: 'Unauthorized' }, 401)
  end

  def status_code_404
    api({ message: 'Not Found' }, 404)
  end

  def status_code_422
    api({ message: 'Unprocessable Entity' }, 422)
  end

  def status_code_500
    api({ message: 'Internal Server Error' }, 500)
  end

  def api(data, status = 200)
    render json: {
        data: data.nil? ? { message: 'Success' } : ( JSON.parse(data) rescue data )
    }, status: status
  rescue
    render json: {
        data: { message: 'Internal server error' }
    }, status: 500
  end

  def each_serializer(resource, options)
    ActiveModelSerializers::SerializableResource.new(resource, each_serializer: options)
  end

  def serializer(resource, options)
    ActiveModelSerializers::SerializableResource.new(resource, serializer: options)
  end
end
