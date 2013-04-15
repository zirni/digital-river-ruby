module DigitalRiver
  class LineItemsResource
    class Update
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def retrieve_response
        session.post(url)
      end

      def url
        id = options[:id]
        quantity = options[:quantity]
        u = File.join(DigitalRiver.config.url, "shoppers/me/carts/active/line-items")
        "#{u}/#{id}?quantity=#{quantity}"
      end
    end
  end
end
