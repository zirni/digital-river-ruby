module DigitalRiver
  class Session
    class Requester
      # Send a get request
      #
      # @return [Response]
      #
      # @api public
      #
      # @example
      #   Requester.new.get("http://domain.de/path")
      def get(*args)
        Request.get(*args)
      end

      # Send a post request
      #
      # @return [Response]
      #
      # @api public
      #
      # @example
      #   Requester.new.post("http://domain.de/path")
      def post(*args)
        Request.post(*args)
      end

      # Send a delete request
      #
      # @return [Response]
      #
      # @api public
      #
      # @example
      #   Requester.new.delete("http://domain.de/path")
      def delete(*args)
        Request.delete(*args)
      end
    end
  end
end
