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

    # It asks the API for a new access token.
    #
    # @return [Auth::Token]
    #
    # @api public
    def token
      response = Request.post(url,
                              :headers => headers,
                              :body => body.to_param)

      Token.build(response.body)
    end

    private

    def url
      File.join(DigitalRiver.config.oauth_url)
    end

    def headers
      {"Accept" => "application/json",
       "Content-Type" => "application/x-www-form-urlencoded" }
    end

    def body
      {:client_id => client_id, :grant_type => grant_type}
    end
  end
end
