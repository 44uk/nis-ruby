module Nis::Unit
  # @attr [String] value
  class Version
    MAINNET =  1744830465
    TESTNET = -1744830463

    attr :value

    def initialize(value)
      @value = value
    end

    # @return [Boolean]
    def mainnet?
      @value == MAINNET
    end

    # @return [Boolean]
    def testnet?
      @value == TESTNET
    end

    def to_s
      testnet? ? 'testnet' :
        mainnet? ? 'mainnet' :
          'unexpected'
    end

    def ==(other)
      @value == other.value
    end
  end
end
