require "spec_helper"
require "./auth"

module DigitalRiver
  describe Auth do
    let(:object) { described_class.new(*arguments) }
    subject { object }

    context ".initialize" do
      let(:arguments) { ["client_id", "password"] }

      its(:client_id) { should eq("client_id") }
      its(:password) { should eq("password") }
    end

    context "spike" do
      it "retrieves a token" do

        Request::Raw.class_eval do
          include Request::Debug
        end

        auth = Auth.new("0bfb94e0f04b78941e7d4d8c9dc65cc2", "password")
        token = auth.token
        session = Session.build(
          Session::Json.build(
            Session::Token.build(Session::Requester.new, token)))


        # Test exceptions
        # requester = Session::Token.new(Session::Requester.new, token)
        # requester = Session::Json.build(Session::Requester.new)
        # requester = Session::Xml.build(Session::Requester.new)
        # requester = session
        # r = requester.get("https://api.digitalriver.com/v1/shoppers/me/produ/")
        # raise r.to_exception
        ###

        # Example shopper resource
        # r = ShopperResource.update(requester, {:currency => "USD", :locale => "en_US"}).response
        # session = Session.build(requester)
        r = session.shopper_resource!
        # session = Session.build(token)

        # r = token.product_search!(:externalReferenceId => "500797", :companyId => "sennheis")
        ###

        # Example by me sku or externalReferenceId search
        # product: Momentum, externalReferenceId: 505630
        # r = token.product_search(:externalReferenceId => "505630", :companyId => "sennheis")
        # r = token.product_search(:externalReferenceId => "95",     :companyId => "sennheis")

        # url = "https://api.digitalriver.com/v1/shoppers/me/products/245551600"
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
        # r = token.product_search
        # r = token.get("https://api.digitalriver.com/v1/shoppers/me/product-search",
        #               :params => {:keyword => "momentum"})
        # r = token.get("https://api.digitalriver.com/v1/shoppers/me/products/257619000")
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
        # session.post("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items",
        #                :body => body)

        # requester = Session::Token.new(Session::Requester.new, token)
        # requester.get("https://api.digitalriver.com/v1/shoppers/me/carts/active/web-checkout")
        # r = token.get("https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items")
        ###
      end
    end

  end
end
