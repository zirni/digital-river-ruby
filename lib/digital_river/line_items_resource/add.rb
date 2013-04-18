module DigitalRiver
  class LineItemsResource
    # Adds a line item to the current shopping cart.
    # Pass a product id provided by Digital River.
    #
    # https://developers.digitalriver.com/resourcemethod/post-shoppersmecartsactiveline-items
    #
    # @example
    #   add = Add.new(session, {:id => 123})
    #   response = add.response
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

      # Send product id in the http payload.
      # With this payload structure, it would be possible to add
      # more than one product at once
      #
      # @return [Hash]
      #
      # @api private
      def body
        body = {:lineItems => {:lineItem => [{:product => {:id => options[:id]}}]}}
      end
    end
  end
end
