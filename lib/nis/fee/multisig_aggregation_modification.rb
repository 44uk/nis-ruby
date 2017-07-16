class Nis::Fee
  class MultisigAggregateModification
    def initialize(transaction)
      @transaction = transaction
    end

    # @return [Integer] fee in micro XEM
    def value
      if @transaction.minCosignatories == 0
        testnet? ?
          0.5 * 1_000_000 :
          (10 + 6 * @transaction.modifications.length) * 1_000_000
      else
        testnet? ?
          0.5 * 1_000_000 :
          (10 + 6 * @transaction.modifications.length + 6) * 1_000_000
      end
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
