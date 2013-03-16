require "typhoeus"
require "concord"
require "anima"
require "json"
require "hash_symbolizer"
require "active_support/core_ext/hash/except"

module DigitalRiver
  class Response
    class Json < self
      def self.build(response)
        new(JSON.parse(response.body), response.code, response.headers)
      end
    end

    include Concord.new(:body, :status, :headers)

    def self.build(response)
      if response.headers["Content-Type"].to_s.include?("application/json")
        Json.build(response)
      else
        new(response.body, response.code, response.headers)
      end
    end
  end

  class Request
    class Raw
      include Concord.new(:url, :options)

      def run
        response = Typhoeus::Request.new(url, options).run
        Response.build(response)
      end
    end

    include Concord.new(:token, :url, :options)

    def self.get(token, url, options = {})
      options.merge!(:method => :get)
      new(token, url, options).run
    end

    def self.post(token, url, options = {})
      options.merge!(:method => :post)
      new(token, url, options).run
    end

    def run
      Raw.new(url, options).run
    end

    def options
      @options.merge(:headers => headers)
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
      def self.build(attributes)
        new(attributes.symbolize_keys)
      end

      include Anima.new(:access_token, :token_type, :expires_in, :refresh_token, :scope)
    end

    URL = "https://api.digitalriver.com/oauth20/token".freeze

    include Concord.new(:client_id, :password)

    def token
      response = Request::Raw.new(URL,
                                  :method => :post,
                                  :headers => {
                                    "Accept" => "application/json"
                                  },
                                  :body => {
                                    :client_id => client_id,
                                    :grant_type => password
                                  }).run
      Token.build(response.body)
    end
  end
end
