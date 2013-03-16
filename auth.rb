require "typhoeus"
require "concord"
require "anima"
require "json"
require "hash_symbolizer"
require "active_support/core_ext/hash/except"

module DigitalRiver
  class Response
    include Concord.new(:body, :status, :headers)

    class Json < self
      def self.build(response)
        new(JSON.parse(response.body), response.code, response.headers)
      end
    end

    def self.build(response)
      if response.headers["Content-Type"].to_s.include?("application/json")
        Json.build(response)
      else
        new(response.body, response.code, response.headers)
      end
    end

    def method_missing(m, *args, &block)
      @response.send(m, *args, &block)
    end
  end

  class Connection
    include Concord.new(:request)

    def self.get(request)
      new(request).get
    end

    def get
      puts request.headers
      response = connection.get(request.url, :headers => request.headers)
      Response.build(response)
    end

    private

    def connection
      Typhoeus
    end
  end

  class Request
    include Concord.new(:token, :url)

    def self.build(token, url)
      new(token, url)
    end

    class Product < self
      # def headers
      #   # super.except("Accept")
      # end
    end

    class Products < self
      URL = "https://api.digitalriver.com/v1/shoppers/me/products".freeze

      def url
        URL
      end
    end

    def get
      Connection.get(self)
    end

    def headers
      {
        "Accept" => "application/json",
        "Authorization" => [token.token_type, token.access_token].join(" ")
      }
    end

  end

  class Auth
    class Token
      include Anima.new(:access_token, :token_type, :expires_in, :refresh_token, :scope)
    end


    URL = "https://api.digitalriver.com/oauth20/token".freeze

    attr_reader :client_id, :password

    def initialize(client_id, password)
      @client_id = client_id
      @password = password
    end

    def token
      response = Typhoeus::Request.post(URL, :body => {:client_id => client_id, :grant_type => password})
      Token.new(JSON.parse(response.body).symbolize_keys)
    end
  end
end
