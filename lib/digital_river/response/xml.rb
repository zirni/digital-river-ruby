module DigitalRiver
  class Response
    class Xml
      def self.build(body, status, headers)
        Response.new(Hash.from_xml(body), status, headers)
      end
    end
  end
end
