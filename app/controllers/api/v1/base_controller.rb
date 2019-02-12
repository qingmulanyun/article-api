module Api::V1
  class BaseController < ApplicationController
    # Generic API stuff
    include Exceptions

    rescue_from ApiStandardError, with: :render_custom_error
    rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error

    def render_custom_error(exception)
      status = exception.custom_status
      Exceptions.log_err(exception)
      render json: {code: exception.code, message: exception.message}, status: status
    end

    def render_validation_error(exception)
      message = "#{exception.class} #{exception.message}"
      Exceptions.log_err(exception)
      render json: {code: ErrorCode::VALIDATION_ERROR_CODE, message: message}, status: 422
    end

    def validate_required_params(required_params, passing_params)
      missing_params = required_params.map(&:to_s) - passing_params.reject { |_, v| v.blank? }.keys
      return if missing_params.count.zero?

      raise ParameterMissing.new(
          ErrorCode::PARM_MISSING_CODE,
          ErrorCode::PARM_MISSING_MSG % [missing_params.join(', ')]
      )
    end

    def valid_date?(date)
      Date.strptime(date, '%Y%m%d') rescue false
    end
  end
end
