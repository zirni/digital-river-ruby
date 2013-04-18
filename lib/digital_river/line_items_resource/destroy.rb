module DigitalRiver
  class LineItemsResource
    # Destroys a line item from the current shopping cart
    # by passing a line item id.
    #
    # https://developers.digitalriver.com/resourcemethod/delete-shoppersmecartsactiveline-itemsid
    #
    # @param [Session] session
    #
    # @param [Hash] options
    #
    # @example
    #   destroy = Destroy.new(session, {:id => 123})
    #   destroy.response
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
