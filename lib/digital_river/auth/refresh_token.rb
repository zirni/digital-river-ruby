module DigitalRiver
  class Auth
    # Refresh a access token. Digital River sets the access token
    # with an one hour expiration. You can refresh your access token
    # whenever you want before or after the access token expired.
    #
    # https://developers.digitalriver.com/resourcemethod/post-oauth20token-refresh-public
    class RefreshToken
      include Concord.new(:client_id, :atoken)

      # Refreshes token, so the ttl live will be increased
      #
      # @param [String] client_id
      #
      # @param [Auth::Token] token
      #
      # @return [Auth::Token]
      #
      # @api public
      #
      # @example
      #   refresh = RefreshToken.new("123abc", token)
      #   refresh.token
      def token
        response = Request.post(url,
                                :headers => headers,
                                :body => body.to_param)

        Token.build(response.body)
      end

      private

      # Returns the refresh token specific url
      #
      # @return [String]
      #
      # @api private
      def url
        File.join(DigitalRiver.config.oauth_url)
      end

      # Returns a http header
      #
      # @return [Hash]
      #
      # @api private
      def headers
        {"Accept" => "application/json",
         "Content-Type" => "application/x-www-form-urlencoded" }
      end

      # Returns the http payload
      #
      # @return [Hash]
      #
      # @api private
      def body
        {:refresh_token => atoken.refresh_token,
         :grant_type => "refresh_token",
         :client_id => client_id}
      end
    end
  end
end
