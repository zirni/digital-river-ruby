module DigitalRiver
  class CheckoutResource
    def self.build(session)
      new(session)
    end

    include Resource
    include Resource::Response

    def retrieve_response
      token = session.token
      r = Session.build(token, Session.xml_requester(token))
      r.get(url)
    end

    def url
      File.join(DigitalRiver.config.url, "shoppers/me/carts/active/web-checkout")
    end
  end
end
