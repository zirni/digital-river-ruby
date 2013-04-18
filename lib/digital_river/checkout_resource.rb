module DigitalRiver
  # A resource to retrieve an url to checkout
  # the shopping cart on DR servers side
  #
  # It returns HTTP status 302 and the checkout url
  # in the HTTP header attribute location. This location
  # you can pass to the user.
  #
  # For more information check out
  # https://developers.digitalriver.com/v1/shoppers/web-checkout-resource
  #
  # @example
  #   checkout = CheckoutResource.build(session)
  #   response = checkout.response
  #   response.headers["location"] #=> checkout url
  #   response.status #=> 302
  class CheckoutResource
    def self.build(session)
      new(session)
    end

    include Resource
    include Resource::Response

    private

    # Specify how to request the resource.
    # It needs/returns XML instead of json
    #
    # @return [DigitalRiver::Response]
    #
    # @api private
    def retrieve_response
      token = session.token
      r = Session.build(token, Session.xml_requester(token))
      r.get(url)
    end

    # @return [String]
    #
    # @api private
    def url
      File.join(DigitalRiver.config.url, "shoppers/me/carts/active/web-checkout")
    end
  end
end
