module DigitalRiver
  class LineItemsResource
    class Add
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      private

      def retrieve_response
        session.post(url, :body => body)
      end

      def url
        File.join(DigitalRiver.config.url, "shoppers/me/carts/active/line-items")
      end

      def body
        body = {:lineItems => {:lineItem => [{:product => {:id => options[:id]}}]}}
      end
    end
  end
end
