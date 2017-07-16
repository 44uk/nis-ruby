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
      (testnet? ? 100 : 5_000) * 1_000_000
    end

    def sub_fee
      (testnet? ? 10 : 200) * 1_000_000
    end
  end
end
