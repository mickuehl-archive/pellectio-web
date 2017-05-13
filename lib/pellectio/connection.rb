
require 'pellectio/errors'

module Pellectio

  class Connection

    attr_reader :url, :options

    def initialize(url, opts)
      case
      when !url.is_a?(String)
        raise ArgumentError, "Expected a String, got: '#{url}'"
      when !opts.is_a?(Hash)
        raise ArgumentError, "Expected a Hash, got: '#{opts}'"
      else
        @url, @options = url, opts

        # new HTTP client and session
        @session = Excon.new(url, options)
      end
    end

    # The actual client that sends HTTP methods to the Delphix Engine.
    def session
      @session
    end
    private :session

    # Send a request to the server with the `
    def request(*args, &block)

      request = compile_request_params(*args, &block)
      log_request(request)

      response = session.request(request)

      log_response(response)

      return parse_json( response.body)

    rescue Excon::Errors::BadRequest => ex
      raise ClientError, ex.response.body
    rescue Excon::Errors::Unauthorized => ex
      raise UnauthorizedError, ex.response.body
    rescue Excon::Errors::NotFound => ex
      raise NotFoundError, ex.response.body
    rescue Excon::Errors::Conflict => ex
      raise ConflictError, ex.response.body
    rescue Excon::Errors::InternalServerError => ex
      raise ServerError, ex.response.body
    rescue Excon::Errors::Timeout => ex
      raise TimeoutError, ex.message
    end

    # Delegate all HTTP methods to the #request.
    [:get, :put, :post, :delete].each do |method|
      define_method(method) { |*args, &block| request(method, *args, &block) }
    end

    def log_request(request)
      #puts "REQ: #{[request[:method], request[:path], request[:query], request[:headers], request[:body]]}"
      #puts "#{[request[:method], request[:path], request[:body]]}"
    end

    def log_response(response)
      #puts "#{[response.headers, response.body]}"
    end

    def to_s
      "Pellectio::Connection { :url => #{url}, :options => #{options} }"
    end

  private

    # Given an HTTP method, path, optional query, extra options, and block,
    # compiles a request.
    def compile_request_params(http_method, path, query = nil, opts = nil, &block)
      query ||= {}
      opts ||= {}
      headers = opts.delete(:headers) || {}
      content_type = 'application/json'
      user_agent = "Pellectio/API"

      {
        :method        => http_method,
        :path          => "#{path}",
        :query         => query,
        :headers       => { 'Content-Type' => content_type,
                            'User-Agent'   => user_agent,
                          }.merge(headers),
        :expects       => (200..204).to_a << 304 << 403 << 500,
        :idempotent    => http_method == :get,
        :request_block => block
      }.merge(opts).reject { |_, v| v.nil? }

    end

    def parse_json(body)
      JSON.parse(body) unless body.nil? || body.empty? || (body == 'null')
    rescue JSON::ParserError => ex
      raise UnexpectedResponseError, ex.message
    end

  end

end
