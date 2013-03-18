module DigitalRiver
  class ProductResource
    class Search
      def self.build(session, options)
        new(session, options)
      end

      URL = "https://api.digitalriver.com/v1/shoppers/me/products".freeze

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        uri = URI.parse(URL)
        uri.query = options.to_query
        uri.to_s
      end
    end
  end
end
