module DigitalRiver
  class Response
    # Represent an API error
    # https://developers.digitalriver.com/page/common-errors
    class Error < self
      class NoneNestedStruct
        def self.transform(error)
          {"code"        => error["error"],
           "description" => error["error_description"],
           "uri"         => error["error_uri"]}
        end
      end

      class NestedStruct
        def self.transform(error)
          error = error["errors"] if error["errors"]
          error = error["error"]
          error = error.first if error.is_a?(Array)

          {"code"        => error["code"],
           "description" => error["description"],
           "uri"         => error["relation"]}
        end
      end

      class FaultStruct
        def self.transform(error)
          {"description" => error.scan(/<faultstring>(.*)<\/faultstring>/).flatten.join,
           "code"        => error.scan(/<errorcode>(.*)<\/errorcode>/).flatten.join,
           "uri"         => ""}
        end
      end

      # Creates an Error instance
      #
      # @return [Error]
      #
      # @api public
      #
      # @example
      #   error = Error.build({"error" => "system-error", "description" => "Critical system error"}, 500, {"Content-Type" => "text/javascript"})
      #   error.errors? #=> true
      #   error.error_messages #=> system-error
      #   raise error.to_exception
      def self.build(body, status, headers)
        error = if body.is_a?(String) && body.start_with?("<fault>")
          FaultStruct.transform(body)
        elsif body["error"].is_a?(String)
          NoneNestedStruct.transform(body)
        elsif body["errors"] || body["error"]
          NestedStruct.transform(body)
        else
          {"code"        => "not given",
           "description" => "not given",
           "uri"         => "not given"}
        end

        new(error, status, headers)
      end

      # Detects if given information is an error
      #
      # @return [Boolean]
      #
      # @api public
      def self.is_error?(body, status, headers)
        body["errors"] || body["error"]
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
        body
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
        BasicError.build(body["code"], body["description"])
      end
    end
  end
end
