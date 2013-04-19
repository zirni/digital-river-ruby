module DigitalRiver
  class ProductResource
    # Create a search instance
    #
    # @param [Session] session
    #
    # @param [Hash] options
    #
    # @return [Search]
    #
    # @api public
    #
    # @example
    #   ProductResource.search(session)
    def self.search(session, options = {})
      Search.build(session, options)
    end
  end
end
