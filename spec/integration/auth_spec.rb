require "spec_helper"

module DigitalRiver
  describe Auth do
    let(:object) { described_class.new(*arguments) }
    subject { object }

    context ".initialize" do
      let(:arguments) { ["client_id", "password"] }

      its(:client_id) { should eq("client_id") }
      its(:grant_type) { should eq("password") }
    end

    context "spike" do
      it "retrieves a token" do
        # VCR.turned_off do
        Request::Raw.class_eval do
          include Request::Debug
        end
        client_id = "0bfb94e0f04b78941e7d4d8c9dc65cc2"

        auth = Auth.new(client_id, "password")
        token = auth.token
        session = Session.build(token)

        # new_token = Auth::RefreshToken.new(client_id, token).token
        new_token = session.refresh_token(client_id)

        session = Session.build(new_token)

        # session = Session.build(
        #   Session::Json.build(
        #     Session::Token.build(Session::Requester.new, token)))

        # session = DigitalRiver.oauth2_session("0bfb94e0f04b78941e7d4d8c9dc65cc2", "password")

        # Example shopper resource
        session.update_shopper_resource(:currency => "USD", :locale => "en_US")
        # session.update_shopper_resource!update_shopper_resource(:currency => "USD", :locale => "en_US")
        # ShopperResource.update(session, {:currency => "USD", :locale => "en_US"}).response
        # session = Session.build(requester)
        # r = session.shopper_resource!
        # session = Session.build(token)
        # r = session.product_search!(:externalReferenceId => "500797", :companyId => "sennheis")
        ###

        # Test exceptions
        # requester = Session::Token.new(Session::Requester.new, token)
        # requester = Session::Json.build(Session::Requester.new)
        # requester = Session::Xml.build(Session::Requester.new)
        # requester = session
        # r = requester.get("https://api.digitalriver.com/v1/shoppers/me/produ/")
        # raise r.to_exception
        ###


        # Example by me sku or externalReferenceId search
        # product: Momentum, externalReferenceId: 505630
        # r = token.product_search(:externalReferenceId => "505630", :companyId => "sennheis")
        # r = token.product_search(:externalReferenceId => "95",     :companyId => "sennheis")

        # url = "https://api.digitalriver.com/v1/shoppers/me/products/245551600"
        # r = session.get("https://api.digitalriver.com/v1/shoppers/me/products/257619000")
        # raise r.inspect
        # r = token.get(url)
        # ap r
        ###

        # Digital River example email
        # r = token.product_search(:externalReferenceId => "95", :companyId => "sennheis")
        # ap r
        # r = token.get("https://api.digitalriver.com/v1/shoppers/me/products/248294700")
        # ap r.body
        ###

        # Product search
        # r = session.product_search(:expand => "all")
        # r = session.product_search(:pageSize => 1000)
        # r = session.get("https://api.digitalriver.com/v1/shoppers/me/product-search",
        #               :params => {:keyword => "momentum"})
        # r = session.get("https://api.digitalriver.com/v1/shoppers/me/products/257619000")
        ###

        # Shopping cart
        # s =<<-EOS
# <lineItems>
        #  <lineItem>
        #         <product><id>23198450</id></product>
        #         <quantity>1</quantity>
        #         <offer><id>2345224</id></offer>
        #  </lineItem>
        #  <lineItem>
        #         <product><id>23183800</id></product>
        #  </lineItem>
# </lineItems>
        # EOS
        # ap Hash.from_xml(s)

        # body = {:lineItems => {:lineItem => [{:product => {:id => 257619000}}]}}

        # p1 = "272115300"
        # p2 = "257619000"

        # r = session.post("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items/productId=#{p1}")
        # raise r.inspect
        # r = session.post("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items?productId=#{p1}")
        # r = session.post("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items?productId=#{p1}")
        # r = session.post("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items?productId=#{p2}")
        # line_item_id = r.body["lineItems"]["lineItem"].first["id"]

        # r = session.post("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items/#{line_item_id}?quantity=#{2}")

        r = session.get("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items")
        # raise r.inspect
        # raise r.body["lineItems"]["lineItem"].size.inspect
        # line_item_id = r.body["lineItems"]["lineItem"].first["id"]

        # r = session.delete("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items/#{line_item_id}")
        # raise r.inspect

        # r = session.post("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items/productId=#{line_item_id}")
        # if r.errors?
        #   raise r.to_exception
        # end

        # requester = Session::Token.new(Session::Requester.new, token)
        # r = session.checkout_resource
        # puts r.headers["Location"]

        # r = requester.get("https://api.digitalriver.com/v1/shoppers/me/carts/active/web-checkout")
        # raise r.inspect
        # r = token.get("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items")
        ###
        # end
      end
    end

  end
end
