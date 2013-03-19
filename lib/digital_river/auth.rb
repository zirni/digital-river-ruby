module DigitalRiver
  class Auth
    URL = "https://api.digitalriver.com/oauth20/token".freeze

    include Concord.new(:client_id, :grant_type)

    def token
      response = Request.post(URL,
                                  :headers => {
                                    "Accept" => "application/json"
                                  },
                                  :body => {
                                    :client_id => client_id,
                                    :grant_type => grant_type
                                  })
      Token.build(response.body)
    end
  end
end
