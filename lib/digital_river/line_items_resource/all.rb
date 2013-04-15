module DigitalRiver
  class LineItemsResource
    class All
      URL = "https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items".freeze

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        URL
      end
    end
  end
end
