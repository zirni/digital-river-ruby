module DigitalRiver
  class Response
    class Xml
      # returns a response parsed as xml
      #
      # @param [string] body
      #
      # @param [integer] status
      #
      # @param [hash] headers
      #
      # @return [response]
      #
      # @api public
      #
      # @example
      #   json.build("<name>zirni</name>", 200, {})
      def self.build(body, status, headers)
        Response.new(Hash.from_xml(body), status, headers)
      end
    end
  end
end
