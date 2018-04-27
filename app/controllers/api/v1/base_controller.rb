class Api::V1::BaseController < ActionController::API
  # Here would be handled all the authentication and authorization logic.

  rescue_from Exception do |exception|
    Rails.logger.error "ERROR #{exception.inspect}"
    Rails.logger.error "Backtrace:\n\t#{exception.backtrace.join("\n\t")}"

    error = { type: 'unknown_error', codes: [] }
    response_hash = errors_json(exception.message).merge(error: error)

    response_hash[:exception_class] = exception.class.to_s
    response_hash[:backtrace] = exception.backtrace

    # Add user informations for Bugsnag if possible.
    # Bugsnag.notify(exception) if Rails.env.production?

    render json: response_hash, status: :internal_server_error
  end

  protected

  def errors_json(messages)
    { raw_error_messages: [*messages] }
  end
end
