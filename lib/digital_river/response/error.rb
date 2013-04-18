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

      # @api public
      def errors?
        true
      end

      # @api public
      def error_messages
        body["error"]
      end

      # @api public
      def to_exception
        error = body["error"]
        error = error.first if error.is_a?(Array)
        BasicError.build(error["code"], error["description"])
      end
    end
  end
end
