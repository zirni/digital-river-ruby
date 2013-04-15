module DigitalRiver
  class LineItemsResource
    class Add
      URL = "https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items".freeze

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def retrieve_response
        session.post(URL, :body => body)
      end

      private

      def body
        body = {:lineItems => {:lineItem => [{:product => {:id => options[:id]}}]}}
      end
    end
  end
end
