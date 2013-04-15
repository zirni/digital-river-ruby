module DigitalRiver
  class Config
    attr_accessor :url

    def url
      @url || File.join(host, "v1")
    end

    def host
      @url || "https://api.digitalriver.com/"
    end
  end
end
