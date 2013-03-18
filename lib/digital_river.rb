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
end

require "digital_river/auth/token"
require "digital_river/resource"
require "digital_river/resource/response"
require "digital_river/product_resource"
require "digital_river/product_resource/search"

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
