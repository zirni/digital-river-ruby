require "spec_helper"

module DigitalRiver
  describe Auth do
    let(:object)     { described_class.new(*arguments) }
    let(:arguments)  { [client_id, grant_type] }
    let(:client_id)  { "client_id" }
    let(:grant_type) { "password" }

    subject { object.token }

    it "retrieves a new access token" do
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

      subject
    end
  end
end
