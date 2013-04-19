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

      # Default retrieve response via get. Overwrite this method in your class
      #
      # @return [Response]
      #
      # @api private
      def retrieve_response
        session.get(url)
      end
      private :retrieve_response

      # Retrieve reponse
      #
      # @return [Response]
      #
      # @api public
      #
      # @example
      #   resource = Class.new do
      #     include Resource::Response
      #
      #     def url
      #       "http://api.url.de"
      #     end
      #   end
      #
      #   resource.response
      def response
        @response ||= retrieve_response
      end

      # Retrieve response and raise exceptions when the response contains errors
      #
      # @return [Response]
      #
      # @api public
      #
      # @example
      #   resource = Class.new do
      #     include Resource::Response
      #
      #     def url
      #       "http://api.url.de"
      #     end
      #   end
      #
      #   resource.response!
      def response!
        return response if !response.errors?

        raise response.to_exception
      end
    end
  end
end
