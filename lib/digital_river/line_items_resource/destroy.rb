module DigitalRiver
  class LineItemsResource
    class Destroy
      URL = "https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items".freeze

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def retrieve_response
        session.delete(url)
      end

      def url
        id = options[:id]
        "#{URL}/#{id}"
      end
    end
  end
end
