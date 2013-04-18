module DigitalRiver
  module Resource
    # Defines the response interface for resources
    #
    # @example
    #   class Sample
    #     include Response
    #   end
    #
    #   sample = Sample.new
    #   sample.response
    #   sample.response!
    module Response
      # @api private
      def retrieve_response
        session.get(url)
      end
      private :retrieve_response

      # Retrieve reponse
      #
      # @api public
      def response
        @response ||= retrieve_response
      end

      # Retrieve response and raise exceptions when
      # the response contains errors
      #
      # @api public
      def response!
        return response if !response.errors?

        raise response.to_exception
      end
    end
  end
end
