require "adamantium"
require "anima"

class Token
  def self.build(attributes)
    new(attributes.symbolize_keys)
  end

  ATTRIBUTES = [:access_token, :token_type, :expires_in, :refresh_token, :scope].freeze

  include Adamantium
  include Anima.new(*ATTRIBUTES)

  def attributes
    ATTRIBUTES.inject({}) do |h, name|
      h[name] = send(name)
      h
    end
  end
end
