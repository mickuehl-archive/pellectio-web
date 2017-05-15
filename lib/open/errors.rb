
module OpenSaas

  class OpenSaasError < StandardError
  end

  # Raised when invalid arguments are passed to a method.
  class ArgumentError < OpenSaasError; end

  # Raised when a request returns a 400.
  class ClientError < OpenSaasError; end

  # Raised when a request returns a 401.
  class UnauthorizedError < OpenSaasError; end

  # Raised when a request returns a 404.
  class NotFoundError < OpenSaasError; end

  # Raised when a request returns a 500.
  class ServerError < OpenSaasError; end

  # Raised when there is an unexpected response code / body.
  class UnexpectedResponseError < OpenSaasError; end

  # Raised when there is an incompatible version of the API.
  class VersionError < OpenSaasError; end

  # Raised when a request times out.
  class TimeoutError < OpenSaasError; end

  # Raised when login fails.
  class AuthenticationError < OpenSaasError; end

  # Raised when an IO action fails.
  class IOError < OpenSaasError; end

end
