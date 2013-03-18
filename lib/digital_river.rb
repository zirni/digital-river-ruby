require "typhoeus"
require "adamantium"
require "concord"
require "anima"
require "json"
require "active_support/core_ext/hash/keys"
require "active_support/core_ext/hash/except"
require "active_support/core_ext/object/to_query"
require "active_support/core_ext/hash/conversions"
require "uri"
require "ostruct"
require "active_support/time_with_zone"
require "awesome_print"

module DigitalRiver
  class BasicError < StandardError
    def self.build(id, message)
      case id
      when "invalid_token"
        InvalidTokenError
      when "resource-not-found"
        ResourceNotFound
      else
        BasicError
      end.new(message)
    end
  end

  class InvalidTokenError < BasicError; end;
  class ResourceNotFound < BasicError; end;
end

require "digital_river/auth/token"
require "digital_river/resource"
require "digital_river/resource/response"
require "digital_river/product_resource"
require "digital_river/product_resource/search"
require "digital_river/request"
require "digital_river/request/raw"
require "digital_river/request/debug"
require "digital_river/response"
require "digital_river/response/json"
require "digital_river/response/xml"
require "digital_river/response/error"
require "digital_river/session"
require "digital_river/session/json"
require "digital_river/session/xml"
require "digital_river/session/token"
require "digital_river/session/requester"

require "digital_river/auth"

def hashes2ostruct(object)
  return case object
  when Hash
    object = object.clone
    object.each do |key, value|
      object[key] = hashes2ostruct(value)
    end
    OpenStruct.new(object)
  when Array
    object = object.clone
    object.map! { |i| hashes2ostruct(i) }
  else
    object
  end
end
