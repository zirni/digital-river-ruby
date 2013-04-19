require "adamantium"
require "anima"

module DigitalRiver
  class Auth
    class Token
      # Returns a Token instance initialized with the given attributes
      #
      # @param [Hash]
      #
      # @return [Auth::Token]
      #
      # @api public
      #
      # @example
      #   token = Token.build({:access_toke => "123abc",
      #                        :token_type => "token_type",
      #                        :expires_in => 3600,
      #                        :refresh_token => "345def",
      #                        :scope => "shoppers"})
      def self.build(attributes)
        new(attributes.symbolize_keys)
      end

      ATTRIBUTES = [:access_token, :token_type, :expires_in, :refresh_token, :scope].freeze

      include Adamantium
      include Anima.new(*ATTRIBUTES)

      # Returns a hash with all values
      #
      # @return [Hash]
      #
      # @api public
      #
      # @example
      #   token = Token.build({:access_toke => "123abc",
      #                        :token_type => "token_type",
      #                        :expires_in => 3600,
      #                        :refresh_token => "345def",
      #                        :scope => "shoppers"})
      #   token.attributes
      def attributes
        ATTRIBUTES.inject({}) do |h, name|
          h[name] = send(name)
          h
        end
      end
    end
  end
end
