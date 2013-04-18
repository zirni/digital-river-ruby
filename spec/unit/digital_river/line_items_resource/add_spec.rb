require "spec_helper"

module DigitalRiver
  class LineItemsResource
    describe Add do
      let(:object)    { described_class.new(*arguments) }
      let(:session)   { mock("session") }
      let(:arguments) { [session, options] }

      subject { object }

      context ".response" do
        let(:url)     { "https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items" }
        let(:body)    { {:lineItems => {:lineItem => [{:product => {:id => options[:id]}}]}} }
        let(:options) { {:id => 123} }

        it "should receive a response" do
          session.should_receive(:post).with(url, :body => body)
          subject.response
        end
      end
    end
  end
end
