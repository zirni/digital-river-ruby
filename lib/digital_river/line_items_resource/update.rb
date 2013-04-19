module DigitalRiver
  class LineItemsResource
    # Update a line items quantity by passing a
    # line item id and a quantity.
    # It returns a HTTP status 204.
    #
    # https://developers.digitalriver.com/resourcemethod/post-shoppersmecartsactiveline-itemsid
    #
    # @example
    #   update = Update.new(session, {:id => 123, :quantity => 2})
    #   response = update.response
    class Update
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      private

      # Create a delete request
      #
      # @return [Response]
      #
      # @api private
      def retrieve_response
        session.post(url)
      end

      # Returns resource url
      #
      # @return [String]
      #
      # @api private
      def url
        id = options[:id]
        quantity = options[:quantity]
        u = File.join(DigitalRiver.config.url, "shoppers/me/carts/active/line-items")
        "#{u}/#{id}?quantity=#{quantity}"
      end
    end
  end
end
