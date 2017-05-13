
module Pellectio

  class PellectioError < StandardError
  end

  # Raised when invalid arguments are passed to a method.
  class ArgumentError < PellectioError; end

  # Raised when a request returns a 400.
  class ClientError < PellectioError; end

  # Raised when a request returns a 401.
  class UnauthorizedError < PellectioError; end

  # Raised when a request returns a 404.
  class NotFoundError < PellectioError; end

  # Raised when a request returns a 500.
  class ServerError < PellectioError; end

  # Raised when there is an unexpected response code / body.
  class UnexpectedResponseError < PellectioError; end

  # Raised when there is an incompatible version of the API.
  class VersionError < PellectioError; end

  # Raised when a request times out.
  class TimeoutError < PellectioError; end

  # Raised when login fails.
  class AuthenticationError < PellectioError; end

  # Raised when an IO action fails.
  class IOError < PellectioError; end

end
