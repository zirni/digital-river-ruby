module DigitalRiver
  class LineItemsResource
    class Destroy
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      private

      def retrieve_response
        session.delete(url)
      end

      def url
        id = options[:id]
        u = File.join(DigitalRiver.config.url, "shoppers/me/carts/active/line-items")
        "#{u}/#{id}"
      end
    end
  end
end
