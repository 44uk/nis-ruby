class Nis::Fee
  class ProvisionNamespace
    def initialize(transaction)
      @transaction = transaction
    end

    # @return [Integer] fee in micro XEM
    def value
      @transaction.root? ? root_fee : sub_fee
    end

    # @return [Integer] fee in micro XEM
    def to_i
      value.to_i
    end

    # @return [Boolean]
    def testnet?
      @transaction.network == :testnet
    end

    private

    def root_fee
      0.15 * 1_000_000
    end

    def sub_fee
      0.15 * 1_000_000
    end
  end
end
