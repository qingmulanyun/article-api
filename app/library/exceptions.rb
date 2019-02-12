# frozen_string_literal: true
# Create a customized exception module with customized error code and message.

module Exceptions
  module ErrorCode
    PARM_MISSING_CODE = 1000
    PARM_MISSING_MSG = "parameter '%s' is required."

    PARM_INVALID_CODE = 1001
    PARM_INVALID_MSG = "parameter '%s' can't be '%s'."

    PARM_CONFLICT_CODE = 1002

    UNAUTHORIZED_CODE = 1003
    UNAUTHORIZED_MSG = 'not authorized.'

    NOT_EXISTS_CODE = 1004
    NOT_EXISTS_MSG = "this %s doesn't exist."

    INTERNAL_ERROR_CODE = 1005

    COMMON_ERROR_CODE = 2000

    VALIDATION_ERROR_CODE = 2001
  end

  class ApiStandardError < StandardError
    @custom_status_code = 500
    attr_accessor :code, :message

    def initialize(code, message)
      self.code = code
      self.message = message
    end

    def custom_status
      self.class.class_eval { @custom_status_code }
    end
  end


  # Bad Request -> Non specific error about the request prepared by the client
  class ParameterMissing < ApiStandardError
    @custom_status_code = 400
  end

  # Parameter not valid
  class ParameterInvalid < ApiStandardError
    @custom_status_code = 400
  end

  # Parameter forbidden
  class ParameterForbidden < ApiStandardError
    @custom_status_code = 403
  end

  # Unauthorized
  class UnauthenticatedError < ApiStandardError
    @custom_status_code = 401
  end

  # Parameter conflict
  class ParameterConflict < ApiStandardError
    @custom_status_code = 409
  end

  # Not Found -> the resource cannot be found according to the client provided resource URI
  class ResourceNotExists < ApiStandardError
    @custom_status_code = 404
  end

  # Internal Server Error -> To indicate server side problem
  class InternalServerError < ApiStandardError
    @custom_status_code = 500
  end

  require 'rails/backtrace_cleaner'
  def self.log_err(exception, extra = nil)
    if exception.nil?
      return Rails.logger.error "err_extra=#{extra}"
    end
    # borrowed code from rails default log output
    annoted_source_code = exception.annoted_source_code.to_s if exception.respond_to?(:annoted_source_code)
    clean_backtrace = Rails::BacktraceCleaner.new.clean(exception.backtrace, :all)
    extra = caller_locations(1, 1)[0].label if extra.nil?

    message = "err_class=#{exception.class}, err_message=#{exception.message}, err_extra=#{extra}, \n"
    message = message + "err_annoted=#{annoted_source_code}, \n"
    message = message + "err_trace=#{clean_backtrace.join('\n')}"
    Rails.logger.error message
  end
end
