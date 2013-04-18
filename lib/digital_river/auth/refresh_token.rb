module DigitalRiver
  class Auth
    # Refresh a access token. Digital River sets the access token
    # with an one hour expiration. You can refresh your access token
    # whenever you want before or after the access token expired.
    #
    # https://developers.digitalriver.com/resourcemethod/post-oauth20token-refresh-public
    #
    # @param [String] client_id
    #
    # @param [Auth::Token] atoken
    #
    # @example
    #   refresh_token = RefreshToken.new("123abc", token)
    #   refresh_token.token #=> returns a new token object you can work with
    class RefreshToken
      include Concord.new(:client_id, :atoken)

      # @return [Auth::Token]
      #
      # @api public
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
