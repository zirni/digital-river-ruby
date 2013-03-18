module DigitalRiver
  class LineItemsResource
    def self.add(session, options = {})
      Add.build(session, options)
    end
  end
end
