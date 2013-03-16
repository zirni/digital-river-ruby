require "spec_helper"
require "./auth"
require "active_support/time_with_zone"
require "awesome_print"

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
        r = Request::Product.new(token, url)
        ap r.get.body
        # p JSON.parse(Request::Products.new(token).get.body)
      end
    end

  end
end
