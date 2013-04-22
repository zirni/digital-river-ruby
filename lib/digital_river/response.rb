module DigitalRiver
  class Response
    include Concord.new(:body, :status, :headers)

    # Build a response object based on the content-type or errors
    #
    # @param [String] body
    #
    # @param [Integer] status
    #
    # @param [Hash] headers
    #
    # @return [Response]
    #
    # @api public
    #
    # @example
    #   Response.build("payload", 200, {})
    def self.build(body, status, headers)
      response = if headers["Content-Type"].to_s.include?("application/json")
        Json.build(body, status, headers)
      elsif headers["Content-Type"].to_s.include?("application/xml")
        Xml.build(body, status, headers)
      else
        new(body, status, headers)
      end

      if response.body && Error.is_error?(response.body, response.status, response.headers)
        response = Error.build(response.body, response.status, response.headers)
      end

      response
    end

    # Errors indicator
    #
    # @return [Boolean]
    #
    # @api public
    #
    # @example
    #   response = Response.build("payload", 200, {})
    #   response.errors?
    def errors?
      false
    end
  end
end
