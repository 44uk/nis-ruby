module Nis::Unit
  # @attr [String] value
  class Version
    MAINNET =  1_744_830_465
    TESTNET = -1_744_830_463

    attr_accessor :value

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

    # @return [String]
    def to_s
      testnet? ? 'testnet' :
        mainnet? ? 'mainnet' :
          'unexpected'
    end

    # @return [Boolean]
    def ==(other)
      @value == other.value
    end
  end
end
