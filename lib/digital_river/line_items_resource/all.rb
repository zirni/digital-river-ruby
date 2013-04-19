module DigitalRiver
  class LineItemsResource
    # Get a list of all line items in the current shopping cart.
    #
    # For more information check out https://developers.digitalriver.com/resourcemethod/get-shoppersmecartsactiveline-items
    # @example
    #   all = All.new(session, {})
    #   response = all.response
    #   response.body["lineItems"]["lineItem"] #=> be careful here: it will return an array or a single item. Ensure to explicit cast it to an array in your application.
    class All
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      private

      # Returns resource url
      #
      # @return [String]
      #
      # @api private
      def url
        File.join(DigitalRiver.config.url, "shoppers/me/carts/active/line-items")
      end
    end
  end
end
