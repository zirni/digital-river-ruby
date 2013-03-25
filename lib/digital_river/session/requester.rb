module DigitalRiver
  class Session
    class Requester
      # def initialize
      #   @connection = Faraday.new
      # end

      def get(*args)
        Request.get(*args)
      end

      def post(*args)
        Request.post(*args)
      end

      def delete(*args)
        Request.delete(*args)
      end
    end
  end
end
