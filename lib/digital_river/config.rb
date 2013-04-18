module DigitalRiver
  class Config
    attr_accessor :url, :oauth_url, :host

    def url
      @url || File.join(host, "v1")
    end

    def oauth_url
      @oauth_url || File.join(host, "oauth20/token")
    end

    def host
      @host || "https://api.digitalriver.com/"
    end
  end
end
