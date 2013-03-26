module DigitalRiver
  class Auth
    URL = "https://api.digitalriver.com/oauth20/token".freeze

    include Concord.new(:client_id, :grant_type)

    def token
      response = Request.post(URL,
                              :headers => headers,
                              :body => body.to_param)

      Token.build(response.body)
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
