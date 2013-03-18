module DigitalRiver
  class Response
    class Json
      def self.build(body, status, headers)
        Response.new(JSON.parse(body), status, headers)
      end
    end
  end
end
