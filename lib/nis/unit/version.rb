module Nis::Unit
  class Version
    MAINNET =  1744830465
    TESTNET = -1744830463

    attr :value

    def initialize(value)
      @value = value
    end

    def mainnet?
      @value == MAINNET
    end

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
