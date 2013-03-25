module DigitalRiver
  class Session
    def self.build(requester)
      new(requester)
    end

    include Concord.new(:requester)

    delegate :get, :post, :delete, :to => :requester

    def shopper_resource
      ShopperResource.build(requester).response
    end

    def shopper_resource!
      ShopperResource.build(requester).response!
    end

    def product_search(options = {})
      ProductResource.search(requester, options).response
    end

    def product_search!(options = {})
      ProductResource.search(requester, options).response!
    end
  end
end
