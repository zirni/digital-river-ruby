module DigitalRiver
  class ShopperResource
    class Update
      URL = "https://api.digitalriver.com/v1/shoppers/me".freeze
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        URL
      end

      def retrieve_response
        session.post(url, :body => {:shopper => options})
      end
    end
  end
end
