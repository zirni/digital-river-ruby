module DigitalRiver
  class CheckoutResource
    def self.build(session)
      new(session)
    end

    URL = "https://api.digitalriver.com/v1/shoppers/me/carts/active/web-checkout".freeze
    include Resource
    include Resource::Response

    def retrieve_response
      token = session.token
      r = Session.build(token, Session.xml_requester(token))
      r.get(URL)
    end
  end
end
