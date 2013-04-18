require "spec_helper"

module DigitalRiver
  describe Session do
    let(:object)    { described_class.new(*arguments) }
    let(:arguments) { [token, requester] }
    let(:token)     { mock("token") }
    let(:requester) { mock("requester") }

    subject { object }

    context "add_line_item" do
      let(:id) { 123 }
      let(:line_item_resource) { mock("line_item_resource") }

      it "should call the LineItemResource" do
        line_item_resource.should_receive(:response)
        LineItemsResource::Add.should_receive(:new).
          with(subject, {:id => id}).and_return(line_item_resource)

        subject.add_line_item(id)
      end

      it "should call the LineItemResource" do
        line_item_resource.should_receive(:response!)
        LineItemsResource::Add.should_receive(:new).
          with(subject, {:id => id}).and_return(line_item_resource)

        subject.add_line_item!(id)
      end
    end
  end
end
