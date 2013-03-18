require "adamantium"
require "anima"

class Token
  def self.build(attributes)
    new(attributes.symbolize_keys)
  end

  include Adamantium
  include Anima.new(:access_token, :token_type, :expires_in, :refresh_token, :scope)
end
