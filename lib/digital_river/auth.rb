module DigitalRiver

  class Response
    class Json
      def self.build(body, status, headers)
        Response.new(JSON.parse(body), status, headers)
      end
    end

    class Xml
      def self.build(body, status, headers)
        Response.new(Hash.from_xml(body), status, headers)
      end
    end

    class Error < self
      # https://developers.digitalriver.com/page/common-errors
      def self.build(body, status, headers)
        new(body["errors"], status, headers)
      end

      def errors?
        true
      end

      def error_messages
        body["error"]
      end

      def to_exception
        error = body["error"]
        error = error.first if error.is_a?(Array)
        BasicError.build(error["code"], error["description"])
      end
    end

    include Concord.new(:body, :status, :headers)

    def self.build(body, status, headers)
      response = if headers["Content-Type"].to_s.include?("application/json")
        Json.build(body, status, headers)
      elsif headers["Content-Type"].to_s.include?("application/xml")
        Xml.build(body, status, headers)
      else
        new(body, status, headers)
      end

      if response.body && response.body["errors"]
        response = Error.build(response.body, response.status, response.headers)
      end

      response
    end

    def errors?
      false
    end
  end

  class Request
    module Debug
      def run
        method = options.fetch(:method, "no method given").upcase
        puts "--- REQUEST: #{method} #{url} ---"
        ap options
        puts "---"

        response = super

        puts "--- RESPONSE: #{response.status} ---"
        ap response.headers
        ap response.body.inspect
        puts "---"

        response
      end
    end

    class Raw
      module Implementation
        def run
          response = Typhoeus::Request.new(url, options).run
          Response.build(response.body, response.code, response.headers)
        end
      end

      include Implementation
      include Concord.new(:url, :options)
    end

    include Concord.new(:url, :options)

    def self.get(url, options = {})
      options.merge!(:method => :get)
      new(url, options).run
    end

    def self.post(url, options = {})
      options.merge!(:method => :post)
      new(url, options).run
    end

    def run
      Raw.new(url, options).run
    end
  end

  class Session
    class Requester

      def get(*args)
        Request.get(*args)
      end

      def post(*args)
        Request.post(*args)
      end
    end

    class Token
      def self.build(requester, token)
        new(requester, token)
      end
      include Concord.new(:requester, :token)

      def get(url, options = {})
        options = prepare_headers(options, headers)
        requester.get(url, options)
      end

      def post(url, options = {})
        options = prepare_headers(options, headers)
        requester.post(url, options)
      end

      private

      def prepare_headers(options, headers)
        options[:headers] = {} if options[:headers].nil?
        options[:headers].reverse_merge!(headers)
        options
      end

      def headers
        {
          "Authorization" => [token.token_type, token.access_token].join(" ")
        }
      end
    end

    class Json
      def self.build(requester)
        new(requester)
      end
      include Concord.new(:requester)

      def get(url, options = {})
        options = prepare_headers(options, headers)

        requester.get(url, options)
      end

      def post(url, options = {})
        options = prepare_headers(options, headers)

        options[:body] = options[:body].to_json
        requester.post(url, options)
      end

      private

      def prepare_headers(options, headers)
        options[:headers] = {} if options[:headers].nil?
        options[:headers].reverse_merge!(headers)
        options
      end

      def headers
        {
          "Content-Type" => "application/json",
                "Accept" => "application/json"
        }
      end
    end

    class Xml
      def self.build(requester)
        new(requester)
      end
      include Concord.new(:requester)

      def get(url, options = {})
        options = prepare_headers(options, headers)

        requester.get(url, options)
      end

      def post(url, options = {})
        options = prepare_headers(options, headers)

        options[:body] = options[:body].to_xml
        requester.post(url, options)
      end

      private

      def prepare_headers(options, headers)
        options[:headers] = {} if options[:headers].nil?
        options[:headers].reverse_merge!(headers)
        options
      end

      def headers
        {
          "Content-Type" => "application/xml",
                "Accept" => "application/xml"
        }
      end
    end

    def self.build(requester)
      new(requester)
    end

    include Concord.new(:requester)

    delegate :get, :post, :to => :requester

    def shopper_resource
      ShopperResource.build(requester).response
    end

    def shopper_resource!
      ShopperResource.build(requester).response!
    end

    def product_search(options = {})
      ProductResource.search(requester, options).response
    end

    def product_search!(options = {})
      ProductResource.search(requester, options).response!
    end
  end

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
