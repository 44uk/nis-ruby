class Nis::Fee
  class Transfer
    FEE_FACTOR = 0.05

    def initialize(transaction)
      @transaction = transaction
    end

    # @return [Integer] fee in micro XEM
    def value
      tmp = if @transaction.has_mosaics?
        mosaics_fee
      else
        FEE_FACTOR * minimum_fee(@transaction.amount / 1_000_000)
      end
      tmp += message_fee if @transaction.has_message?
      tmp * 1_000_000
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

    def minimum_fee(base)
      tmp = [1, base / 10_000].max
      tmp > 25 ? 25 : tmp
    end

    def message_fee
      FEE_FACTOR * [1, (@transaction.message.bytesize / 2 / 32) + 1].max
    end

    def mosaics_fee
      raise NotImplementedError, 'not implemented calculation mosaics fee.'
    end
  end
end
