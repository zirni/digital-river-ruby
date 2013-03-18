module DigitalRiver
  class Response
    include Concord.new(:body, :status, :headers)

    def self.build(body, status, headers)
      response = if headers["Content-Type"].to_s.include?("application/json")
        Json.build(body, status, headers)
      elsif headers["Content-Type"].to_s.include?("application/xml")
        Xml.build(body, status, headers)
      else
        new(body, status, headers)
      end

      if response.body && response.body["errors"]
        response = Error.build(response.body, response.status, response.headers)
      end

      response
    end

    def errors?
      false
    end
  end
end
