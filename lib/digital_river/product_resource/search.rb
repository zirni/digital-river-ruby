module DigitalRiver
  class ProductResource
    class Search
      # Create a search instance
      #
      # @param [Session] session
      #
      # @param [Hash] options
      #
      # @return [Search]
      #
      # @api public
      #
      # @example
      #   Search.build(session, {})
      def self.build(session, options)
        new(session, options)
      end

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      private

      # Returns resource url
      #
      # @return [String]
      #
      # @api private
      def url
        u = File.join(DigitalRiver.config.url, "shoppers/me/products")
        uri = URI.parse(u)
        uri.query = options.to_query
        uri.to_s
      end
    end
  end
end
