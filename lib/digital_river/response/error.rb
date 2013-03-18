module DigitalRiver
  class Response
    class Error < self
      # https://developers.digitalriver.com/page/common-errors
      def self.build(body, status, headers)
        new(body["errors"], status, headers)
      end

      def errors?
        true
      end

      def error_messages
        body["error"]
      end

      def to_exception
        error = body["error"]
        error = error.first if error.is_a?(Array)
        BasicError.build(error["code"], error["description"])
      end
    end
  end
end
