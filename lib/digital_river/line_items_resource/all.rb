module DigitalRiver
  class LineItemsResource
    class All
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        File.join(DigitalRiver.config.url, "shoppers/me/carts/active/line-items")
      end
    end
  end
end
