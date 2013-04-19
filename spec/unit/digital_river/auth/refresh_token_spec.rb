require "spec_helper"

module DigitalRiver
  class Auth
    describe RefreshToken do
      let(:object)        { described_class.new(*arguments) }
      let(:arguments)     { [client_id, token] }
      let(:client_id)     { "client_id" }
      let(:token)         { Auth::Token.build(token_attributes) }
      let(:grant_type)    { "refresh_token" }
      let(:refresh_token) { "refresh_token" }

      let(:token_attributes) do
        {:access_token  => "access_token",
         :token_type    => "token_type",
         :expires_in    => 123,
         :refresh_token => "refresh_token",
         :scope         => "scope"}
      end

      subject { object.token }

      context ".token" do
        before(:each) do
          url = "https://api.digitalriver.com/oauth20/token"

          headers = {"Accept"       => "application/json",
                     "Content-Type" => "application/x-www-form-urlencoded" }

          body    = {:client_id     => client_id,
                     :refresh_token => refresh_token,
                     :grant_type    => grant_type}


          response = OpenStruct.new(:body => token.attributes)

          Request.should_receive(:post).
            with(url, :headers => headers, :body => body.to_param).
            and_return(response)
        end

        it "retrieves a new access token" do
          subject.should be_an_instance_of(Auth::Token)
        end
      end
    end
  end
end
