module DigitalRiver
  # Creates a session by passing a client_id to Digital River.
  # It will return a access_token we need to authorize all
  # future API request.
  #
  # https://developers.digitalriver.com/apis/list/674/apisuite/oauth-api
  #
  # @example
  #   auth = Auth.new("abc123", :password)
  #   token = auth.token
  #   token.access_token #=> long string :)
  class Auth
    include Concord.new(:client_id, :grant_type)

    # It asks the API for a new access token
    #
    # @return [Auth::Token]
    #
    # @api public
    #
    # @example
    #   Auth.new("123abc", :password).token
    def token
      response = Request.post(url,
                              :headers => headers,
                              :body => body.to_param)

      Token.build(response.body)
    end

    private

    # Returns the oauth specific url
    #
    # @return [String]
    #
    # @api private
    def url
      File.join(DigitalRiver.config.oauth_url)
    end

    # Returns http header
    #
    # @return [Hash]
    #
    # @api private
    def headers
      {"Accept" => "application/json",
       "Content-Type" => "application/x-www-form-urlencoded" }
    end

    # Returns the http payload to be send
    #
    # @return [Hash]
    #
    # @api private
    def body
      {:client_id => client_id, :grant_type => grant_type}
    end
  end
end
