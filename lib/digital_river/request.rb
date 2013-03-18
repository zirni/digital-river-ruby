module DigitalRiver
  class Request
    include Concord.new(:url, :options)

    def self.get(url, options = {})
      options.merge!(:method => :get)
      new(url, options).run
    end

    def self.post(url, options = {})
      options.merge!(:method => :post)
      new(url, options).run
    end

    def run
      Raw.new(url, options).run
    end
  end
end
