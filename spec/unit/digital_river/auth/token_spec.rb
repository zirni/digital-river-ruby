require "spec_helper"

module DigitalRiver
  class Auth
    describe Token do
      let(:object) { described_class.build(*arguments) }
      subject { object }

      context "#build" do
        let(:arguments) do
          [
            {:access_token  => "access_token",
            :token_type    => "token_type",
            :expires_in    => 123,
            :refresh_token => "refresh_token",
            "scope"        => "scope"}
          ]
        end

        its(:access_token) { should eq("access_token") }
        its(:token_type) { should eq("token_type") }
        its(:expires_in) { should eq(123) }
        its(:refresh_token) { should eq("refresh_token") }
        its(:scope) { should eq("scope") }

        its(:attributes) { should eq(arguments.first.symbolize_keys) }
      end
    end
  end
end
