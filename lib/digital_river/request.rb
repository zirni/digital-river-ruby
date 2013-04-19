module DigitalRiver
  class Request
    include Concord.new(:url, :options)

    # Send a get request
    #
    # @return [Response]
    #
    # @api public
    #
    # @example
    #   Request.get("http://domain.de/path", {})
    def self.get(url, options = {})
      options.merge!(:method => :get)
      new(url, options).run
    end

    # Send a post request
    #
    # @return [Response]
    #
    # @api public
    #
    # @example
    #   Request.post("http://domain.de/path", {})
    def self.post(url, options = {})
      options.merge!(:method => :post)
      new(url, options).run
    end

    # Send a post request
    #
    # @return [Response]
    #
    # @api public
    #
    # @example
    #   Request.delete("http://domain.de/path", {})
    def self.delete(url, options = {})
      options.merge!(:method => :delete)
      new(url, options).run
    end

    # Create a raw request and executes it
    #
    # @return [Response]
    #
    # @api public
    #
    # @example
    #   Request.new("http://domain.de/path", {:method => :get}).run
    def run
      Raw.new(url, options).run
    end
  end
end
