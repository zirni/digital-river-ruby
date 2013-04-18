module DigitalRiver
  # Common interface object to access all kinds of API call.
  # Using the session object is the common and preferable way to work.
  #
  # @example
  #   session = Sessio.build(token)
  #   session.checkout_resource #=> Response object
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

    def refresh_token(client_id, token = self.token)
      Auth::RefreshToken.new(client_id, token).token
    end

    def update_shopper_resource(options = {})
      ShopperResource.update(self, options).response
    end

    def update_shopper_resource!(options = {})
      ShopperResource.update(self, options).response!
    end

    def line_items(options = {})
      LineItemsResource::All.new(self, options).response
    end

    def line_items!(options = {})
      LineItemsResource::All.new(self, options).response!
    end

    def add_line_item(id)
      options = {:id => id}
      LineItemsResource::Add.new(self, options).response
    end

    def add_line_item!(id)
      options = {:id => id}
      LineItemsResource::Add.new(self, options).response!
    end

    def update_line_item(id, quantity)
      options = {:id => id, :quantity => quantity}
      LineItemsResource::Update.new(self, options).response
    end

    def update_line_item!(id, quantity)
      options = {:id => id, :quantity => quantity}
      LineItemsResource::Update.new(self, options).response!
    end

    def delete_line_item(id)
      options = {:id => id}
      LineItemsResource::Destroy.new(self, options).response
    end

    def delete_line_item!(id)
      options = {:id => id}
      LineItemsResource::Destroy.new(self, options).response!
    end
  end
end
