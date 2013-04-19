module DigitalRiver
  class Response
    class Json
      # Returns a response parsed as json
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
      #   Json.build("{1:1}", 200, {})
      def self.build(body, status, headers)
        Response.new(JSON.parse(body), status, headers)
      end
    end
  end
end
