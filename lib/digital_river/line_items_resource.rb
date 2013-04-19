module DigitalRiver
  class LineItemsResource
    # Returns a instance of Add
    #
    # @param [Session] session
    #
    # @param [Hash] options
    #
    # @return [Add]
    #
    # @api public
    #
    # @example
    #   add = LineItemsResource.add(session)
    def self.add(session, options = {})
      Add.build(session, options)
    end
  end
end
