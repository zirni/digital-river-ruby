module DigitalRiver
  class Session
    class Json
      def self.build(requester)
        new(requester)
      end
      include Concord.new(:requester)

      def get(url, options = {})
        options = prepare_headers(options, headers)

        requester.get(url, options)
      end

      def post(url, options = {})
        options = prepare_headers(options, headers)

        options[:body] = options[:body].to_json
        requester.post(url, options)
      end

      def delete(url, options = {})
        options = prepare_headers(options, headers)

        requester.delete(url, options)
      end

      private

      def prepare_headers(options, headers)
        options[:headers] = {} if options[:headers].nil?
        options[:headers].reverse_merge!(headers)
        options
      end

      def headers
        { "Accept" => "application/json" }
      end
    end
  end
end
