module DigitalRiver
  class Session
    class Token
      def self.build(requester, token)
        new(requester, token)
      end
      include Concord.new(:requester, :token)

      def get(url, options = {})
        options = prepare_headers(options, headers)
        requester.get(url, options)
      end

      def post(url, options = {})
        options = prepare_headers(options, headers)
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
        {
          "Authorization" => [token.token_type, token.access_token].join(" ")
        }
      end
    end
  end
end
