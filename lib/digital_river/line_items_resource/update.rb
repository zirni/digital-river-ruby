module DigitalRiver
  class LineItemsResource
    class Update
      URL = "https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items".freeze

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def retrieve_response
        session.post(url)
      end

      def url
        id = options[:id]
        quantity = options[:quantity]
        "#{URL}/#{id}?quantity=#{quantity}"
      end
    end
  end
end
