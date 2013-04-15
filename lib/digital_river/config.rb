module DigitalRiver
  class Config
    attr_accessor :url, :host

    def url
      @url || File.join(host, "v1")
    end

    # host is used to for authentication
    # it has no versioning in the path
    def host
      @host || "https://api.digitalriver.com/"
    end
  end
end
