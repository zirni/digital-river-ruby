module DigitalRiver
  class ProductResource
    def self.search(session, options = {})
      Search.build(session, options)
    end
  end
end
