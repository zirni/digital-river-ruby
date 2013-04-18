module DigitalRiver
  class ShopperResource
    class Update
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      private

      def retrieve_response
        session.post(url, :body => {:shopper => options})
      end

      def url
        File.join(DigitalRiver.config.url, "shoppers/me")
      end
    end
  end
end
