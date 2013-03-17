require "typhoeus"
require "concord"
require "anima"
require "json"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/hash/except"
require "active_support/core_ext/object/to_query"
require "active_support/core_ext/hash/conversions"
require "uri"
require "ostruct"
require "active_support/time_with_zone"
require "awesome_print"

def hashes2ostruct(object)
  return case object
  when Hash
    object = object.clone
    object.each do |key, value|
      object[key] = hashes2ostruct(value)
    end
    OpenStruct.new(object)
  when Array
    object = object.clone
    object.map! { |i| hashes2ostruct(i) }
  else
    object
  end
end

module DigitalRiver
  class Response
    class Json
      def self.build(body, status, headers)
        Response.new(JSON.parse(body), status, headers)
      end
    end

    class Error < self
      def self.build(body, status, headers)
        new(body["errors"], status, headers)
      end

      def errors?
        true
      end

      def error_messages
        body["error"]
      end
    end

    include Concord.new(:body, :status, :headers)

    def self.build(body, status, headers)
      response = if headers["Content-Type"].to_s.include?("application/json")
        Json.build(body, status, headers)
      else
        new(body, status, headers)
      end

      if body["errors"]
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
        ap response.body
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

      # def options
      #   @options.merge(:verbose => true)
      # end

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
      @options[:headers] = {} if @options[:headers].nil?
      @options[:headers].merge!(headers)

      @options
    end

    def headers
      {
        "Accept" => "application/json",
        "Authorization" => [token.token_type, token.access_token].join(" ")
      }
    end
  end

  class Session
    # def 
  end

  class Auth
    class Token
      def self.build(attributes)
        new(attributes.symbolize_keys)
      end

      include Anima.new(:access_token, :token_type, :expires_in, :refresh_token, :scope)

      def get(*args)
        Request.get(self, *args)
      end

      def post(*args)
        Request.post(self, *args)
      end

      def shopper_resource
        ShopperResource.build(self).response
      end

      def shopper_resource!
        ShopperResource.build(self).response!
      end

      def product_search(options = {})
        ProductResource.search(self, options).response
      end

      def product_search!(options = {})
        ProductResource.search(self, options).response!
      end
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

  module Resource
    include Concord.new(:session)

    module Response

      def retrieve_response
        session.get(url)
      end

      def response
        @response ||= retrieve_response
      end

      def response!
        return response if !response.errors?

        raise response.error_messages.inspect
      end
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
        session.post(url, :body => {:shopper => options}.to_json,
                          :headers => {'Content-Type' => 'application/json'})
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

  class ProductResource
    def self.search(session, options = {})
      Search.build(session, options)
    end

    class Search
      def self.build(session, options)
        new(session, options)
      end

      URL = "https://api.digitalriver.com/v1/shoppers/me/products".freeze

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
