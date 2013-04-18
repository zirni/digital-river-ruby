module DigitalRiver
  class Config
    # @api public
    attr_writer :url

    # @api public
    attr_writer :oauth_url

    # @api public
    attr_writer :host

    # The url prefix all resources use to access the API
    #
    # @return [String]
    #
    # @api public
    def url
      @url || File.join(host, "v1")
    end

    # The url the Auth classes use
    #
    # @return [String]
    #
    # @api public
    def oauth_url
      @oauth_url || File.join(host, "oauth20/token")
    end

    # The API host end point
    #
    # @return [String]
    #
    # @api public
    def host
      @host || "https://api.digitalriver.com/"
    end
  end
end
