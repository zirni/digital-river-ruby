module DigitalRiver
  class LineItemsResource
    class Add
      URL = "https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items".freeze

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
