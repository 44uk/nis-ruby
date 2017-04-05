module Nis::Unit
  # @attr [String] value
  class Address
    attr_accessor :value

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

    # @return [String]
    def to_s
      @value
    end

    # @return [Boolean]
    def ==(other)
      @value == other.value
    end
  end
end
