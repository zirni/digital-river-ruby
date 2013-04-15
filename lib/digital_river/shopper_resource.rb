module DigitalRiver
  class ShopperResource
    def self.build(session)
      new(session)
    end

    def self.update(session, options)
      Update.new(session, options)
    end

    include Resource
    include Resource::Response

    def url
      File.join(DigitalRiver.config.url, "shoppers/me?expand=all")
    end
  end
end
