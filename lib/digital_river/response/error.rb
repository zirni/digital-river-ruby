module DigitalRiver
  class Response
    # Represent an API error
    # https://developers.digitalriver.com/page/common-errors
    class Error < self
      # Creates an Error instance
      # @return [Error]
      #
      # @api public
      #
      # @example
      #   error = Error.build({"errors" => "system-error"}, 500, {"Content-Type" => "text/javascript"})
      #   error.errors? #=> true
      #   error.error_messages #=> system-error
      #   raise error.to_exception
      def self.build(body, status, headers)
        new(body["errors"], status, headers)
      end

      # Errors indicator
      #
      # @return [Boolean]
      #
      # @api public
      #
      # @example
      #   response = Error.build("payload", 200, {})
      #   response.errors?
      def errors?
        true
      end

      # Returns error messages
      #
      # @return [Hash]
      #
      # @api public
      #
      # @example
      #   error = Error.build("payload", 200, {})
      #   error.error_messages
      def error_messages
        body["error"]
      end

      # Converts the error to an exception
      #
      # @return [BasicError]
      #
      # @api public
      #
      # @example
      #   error = Error.build("payload", 200, {})
      #   error.to_exception
      def to_exception
        error = body["error"]
        error = error.first if error.is_a?(Array)
        BasicError.build(error["code"], error["description"])
      end
    end
  end
end
