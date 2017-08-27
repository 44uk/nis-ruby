class Nis::Fee
  class Transfer
    def initialize(transaction)
      @transaction = transaction
    end

    # @return [Integer] fee in micro XEM
    def value
      tmp = 0

      if @transaction.mosaics.empty?
        tmp += min_fee
      else
        tmp += mosaics_fee
      end

      if @transaction.message.bytesize > 0
        tmp += message_fee
      end

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

    def min_fee
      tmp = [1, @transaction.amount / 1_000_000 / 10_000].max
      tmp = (tmp > 25 ? 25 : tmp)
      0.05 * tmp
    end

    def message_fee
      tmp = [1, (@transaction.message.bytesize / 2 / 32) + 1].max
      0.05 * tmp
    end

    def mosaics_fee
      raise NotImplementedError, 'not implemented calculation mosaics fee.'
    end
  end
end
