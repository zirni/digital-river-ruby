module DigitalRiver
  class Request
    module Debug
      # Prints debug information about request/response
      #
      # @return [Response]
      #
      # @api public
      #
      # @example
      #   Request::Raw.class_eval do
      #     include Debug
      #   end
      def run
        method = options.fetch(:method, "no method given").upcase
        puts "--- REQUEST: #{method} #{url} ---"
        ap options
        puts "---"

        response = super

        puts "--- RESPONSE: #{response.status} ---"
        ap response.headers
        ap response.body
        puts "---"

        response
      end
    end
  end
end
