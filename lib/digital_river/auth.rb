module DigitalRiver

  class Auth
    URL = "https://api.digitalriver.com/oauth20/token".freeze

    include Concord.new(:client_id, :password)

    def token
      response = Request.post(URL,
                                  :headers => {
                                    "Accept" => "application/json"
                                  },
                                  :body => {
                                    :client_id => client_id,
                                    :grant_type => password
                                  })
      Token.build(response.body)
    end
  end

  class ShopperResource
    def self.build(session)
      new(session)
    end

    def self.update(session, options)
      Update.new(session, options)
    end

    class Update
      URL = "https://api.digitalriver.com/v1/shoppers/me".freeze
      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        URL
      end

      def retrieve_response
        session.post(url, :body => {:shopper => options})
      end
    end

    URL = "https://api.digitalriver.com/v1/shoppers/me".freeze
    include Resource
    include Resource::Response

    def url
      URL
    end
  end

  class LineItemsResource
    def self.add(session, options = {})
      Add.build(session, options)
    end

    class Add
      URL = "https://api.digitalriver.com/v1/shoppers/me/carts/active/line-items".freeze

      include Resource
      include Resource::Response
      include Concord.new(:session, :options)

      def url
        uri = URI.parse(URL)
        uri.query = options.to_query
        uri.to_s
      end
    end
  end

end
