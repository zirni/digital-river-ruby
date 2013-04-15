module DigitalRiver
  class Session
    def self.build(token, requester = nil)
      requester = json_requester(token) unless requester
      new(token, requester)
    end

    def self.json_requester(token)
      Session::Json.build(token_requester(token))
    end

    def self.xml_requester(token)
      Session::Xml.build(token_requester(token))
    end

    def self.token_requester(token)
      Session::Token.build(Session::Requester.new, token)
    end

    include Concord.new(:token, :requester)

    delegate :get, :post, :delete, :to => :requester

    def shopper_resource
      ShopperResource.build(self).response
    end

    def shopper_resource!
      ShopperResource.build(self).response!
    end

    def product_search(options = {})
      ProductResource.search(self, options).response
    end

    def product_search!(options = {})
      ProductResource.search(self, options).response!
    end

    def checkout_resource
      CheckoutResource.build(self).response
    end

    def checkout_resource
      CheckoutResource.build(self).response!
    end
  end
end
