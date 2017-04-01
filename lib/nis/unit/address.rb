module Nis::Unit
  # @attr [String] value
  # @attr [String] first_char
  class Address
    attr :value, :first_char

    def initialize(value)
      @value = value
      @first_char = @value[0]
    end

    # @return [Boolean]
    def valid?
      !!(@value =~ /[ABCDEFGHIJKLMNOPQRSTUVWXYZ234567]{40}/)
    end

    # @return [Boolean]
    def mainnet?
      @first_char == 'N'
    end

    # @return [Boolean]
    def testnet?
      @first_char == 'T'
    end

    def to_s
      @value
    end

    def ==(other)
      @value == other.value
    end
  end
end
