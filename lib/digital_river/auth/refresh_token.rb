# https://developers.digitalriver.com/resourcemethod/post-oauth20token-refresh-public
module DigitalRiver
  class Auth
    class RefreshToken
      include Concord.new(:client_id, :atoken)

      def token
        response = Request.post(url,
                                :headers => headers,
                                :body => body.to_param)

        Token.build(response.body)
      end

      def url
        File.join(DigitalRiver.config.oauth_url)
      end

      private

      def headers
        {"Accept" => "application/json",
         "Content-Type" => "application/x-www-form-urlencoded" }
      end

      def body
        {:refresh_token => atoken.refresh_token,
         :grant_type => "refresh_token",
         :client_id => client_id}
      end
    end
  end
end
