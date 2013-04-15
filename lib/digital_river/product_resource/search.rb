module DigitalRiver
  class ProductResource
    class Search
      def self.build(session, options)
        new(session, options)
      end

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        u = File.join(DigitalRiver.config.url, "shoppers/me/products")
        uri = URI.parse(u)
        uri.query = options.to_query
        uri.to_s
      end
    end
  end
end
