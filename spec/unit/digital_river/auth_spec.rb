require "spec_helper"

module DigitalRiver
  describe Auth do
    let(:object)     { described_class.new(*arguments) }
    let(:arguments)  { [client_id] }
    let(:client_id)  { "client_id" }
    let(:grant_type) { "password" }

    subject { object.token }

    context "#token" do
      before(:each) do
        url = "https://api.digitalriver.com/oauth20/token"

        headers = {"Accept"       => "application/json",
                   "Content-Type" => "application/x-www-form-urlencoded" }

        body    = {:client_id     => client_id,
                   :grant_type    => grant_type}

        token = {:access_token  => "access_token",
                 :token_type    => "token_type",
                 :expires_in    => 123,
                 :refresh_token => "refresh_token",
                 :scope         => "scope"}

        response = OpenStruct.new(:body => token)

        Request.should_receive(:post).
          with(url, :headers => headers, :body => body.to_param).
          and_return(response)
      end

      its(:access_token) { should eq("access_token") }
      its(:token_type) { should eq("token_type") }
      its(:expires_in) { should eq(123) }
      its(:refresh_token) { should eq("refresh_token") }
      its(:scope) { should eq("scope") }

      it "retrieves a new access token" do
        subject.should be_an_instance_of(Auth::Token)
      end
    end
  end
end
