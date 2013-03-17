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
        auth = Auth.new("0bfb94e0f04b78941e7d4d8c9dc65cc2", "password")
        token = auth.token
        url = "https://api.digitalriver.com/v1/shoppers/me/products/248294600"
        # URL = "https://api.digitalriver.com/v1/shoppers/me/products".freeze
        # r = Request.get(token, url)
        # ap r.body
        # token.product_search

        Request::Raw.class_eval do
          include Request::Debug
        end
        # r = token.product_search(:companyId => "sennheis", :externalReferenceId => "500797")
        # r = token.product_search(:externalReferenceId => "500797")


        # example by me sku or externalReferenceId search
        # product: e 602-II, externalReferenceId: 500797
        r = token.product_search!(:externalReferenceId => "500797", :companyId => "sennheis")
        ap r.body

        # url = "https://api.digitalriver.com/v1/shoppers/me/products/245551600"
        # r = token.get(url)
        # ap r
        ###

        # example shopper resource
        # r = ShopperResource.build(token)
        # r = token.shopper_resource!
        # ap r.body

        # ShopperResource.update(token)

        # Digital River example email
        # r = token.product_search(:externalReferenceId => "95", :companyId => "sennheis")
        # ap r
        # r = token.get("https://api.digitalriver.com/v1/shoppers/me/products/248294700")
        # ap r.body
        ###

        # https://api.digitalriver.com/v1/shoppers/me/products?externalReferenceId=95&companyId=sennheis
        # https://api.digitalriver.com/v1/shoppers/me/products?companyId=sennheis&externalReferenceId=500797
        # puts r.totalResults
        # Product.search(token, :companyId => "sennheis", :sku => "504568")
      end
    end

  end
end
