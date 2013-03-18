module DigitalRiver
  class Request
    module Debug
      def run
        method = options.fetch(:method, "no method given").upcase
        puts "--- REQUEST: #{method} #{url} ---"
        ap options
        puts "---"

        response = super

        puts "--- RESPONSE: #{response.status} ---"
        ap response.headers
        ap response.body.inspect
        puts "---"

        response
      end
    end
  end
end
