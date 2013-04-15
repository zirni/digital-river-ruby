module DigitalRiver
  class ShopperResource
    class Update
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        File.join(DigitalRiver.config.url, "shoppers/me")
      end

      def retrieve_response
        session.post(url, :body => {:shopper => options})
      end
    end
  end
end
