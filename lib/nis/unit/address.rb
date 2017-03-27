module Nis::Unit
  class Address
    attr :value, :first_char

    def initialize(value)
      @value = value
      @first_char = @value[0]
    end

    def valid?
      !!(@value =~ /[ABCDEFGHIJKLMNOPQRSTUVWXYZ234567]{40}/)
    end

    def mainnet?
      @first_char == 'N'
    end

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
