module DigitalRiver
  module Resource
    module Response
      def retrieve_response
        session.get(url)
      end

      def response
        @response ||= retrieve_response
      end

      def response!
        return response if !response.errors?

        raise response.to_exception
      end
    end
  end
end
