module DigitalRiver
  class Session
    class Requester
      def get(*args)
        Request.get(*args)
      end

      def post(*args)
        Request.post(*args)
      end
    end
  end
end
