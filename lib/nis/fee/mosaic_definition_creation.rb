class Nis::Fee
  class MosaicDefinitionCreation
    def initialize(transaction)
      @transaction = transaction
    end

    # @return [Integer] fee in micro XEM
    def value
      (testnet? ? 10 : 500) * 1_000_000
    end

    # @return [Integer] fee in micro XEM
    def to_i
      value.to_i
    end

    # @return [Boolean]
    def testnet?
      @transaction.network == :testnet
    end
  end
end
