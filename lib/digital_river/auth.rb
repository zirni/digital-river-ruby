module DigitalRiver
  class Auth
    include Concord.new(:client_id, :grant_type)

    # It asks the API for a new access token
    def token
      response = Request.post(url,
                              :headers => headers,
                              :body => body.to_param)

      Token.build(response.body)
    end

    def url
      File.join(DigitalRiver.config.host, "oauth20/token")
    end

    private

    def headers
      {"Accept" => "application/json",
       "Content-Type" => "application/x-www-form-urlencoded" }
    end

    def body
      {:client_id => client_id, :grant_type => grant_type}
    end
  end
end
