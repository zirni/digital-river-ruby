module DigitalRiver
  class Request
    class Raw
      module Implementation
        # Executes a http request
        #
        # @return [Response]
        #
        # @api public
        #
        # @example
        #   Raw.new("http://domain.de/", {:method => :get}).run
        def run
          response = Typhoeus::Request.new(url, options).run
          Response.build(response.body, response.code, response.headers)
        end
      end

      include Implementation
      include Concord.new(:url, :options)
    end
  end
end
