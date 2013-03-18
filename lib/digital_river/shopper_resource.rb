module DigitalRiver
  class ShopperResource
    def self.build(session)
      new(session)
    end

    def self.update(session, options)
      Update.new(session, options)
    end

    URL = "https://api.digitalriver.com/v1/shoppers/me".freeze
    include Resource
    include Resource::Response

    def url
      URL
    end
  end
end
