module DigitalRiver
  class Config
    # Set an url
    #
    # @return [undefined]
    #
    # @api public
    #
    # @example
    #   Config.new.url = "an url"
    attr_writer :url

    # Set a oauth_url
    #
    # @return [undefined]
    #
    # @api public
    #
    # @example
    #   Config.new.oauth_url = "an url"
    attr_writer :oauth_url

    # Set a host
    #
    # @return [undefined]
    #
    # @api public
    #
    # @example
    #   Config.new.host = "a host"
    attr_writer :host

    # The url prefix all resources use to access the API
    #
    # @return [String]
    #
    # @api public
    #
    # @example
    #   Config.new.url
    def url
      @url || File.join(host, "v1")
    end

    # The url the Auth classes use
    #
    # @return [String]
    #
    # @api public
    #
    # @example
    #   Config.new.oauth_url
    def oauth_url
      @oauth_url || File.join(host, "oauth20/token")
    end

    # The API host end point
    #
    # @return [String]
    #
    # @api public
    #
    # @example
    #   Config.new.host
    def host
      @host || "https://api.digitalriver.com/"
    end
  end
end
