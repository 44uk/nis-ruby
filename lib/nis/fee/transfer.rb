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
      FEE_FACTOR * @transaction.mosaics.inject(0) do |sum, mo_attachment|
        mo = mo_attachment.mosaic_definition
        quantity = mo_attachment.quantity
        tmp_fee = 0
        if mo.divisibility == 0 && mo.initial_supply <= 10_000
          # It is called *Small Business Mosaic Fee*
          supply_related_adjustment = 0
          tmp_fee = 1
        else
          # custom mosaic fee, Max is 1.25.
          max_mosaic_quantity = 9_000_000_000_000_000
          total_mosaic_quantity = mo.initial_supply * (10**mo.divisibility)
          supply_related_adjustment = (0.8 * (Math.log(max_mosaic_quantity / total_mosaic_quantity))).floor

          num_nem = if mo.initial_supply == 0
            0
          else
            8_999_999_999.to_f * quantity * 1_000_000 / mo.initial_supply / (10**(mo.divisibility + 6))
          end
          tmp_fee = minimum_fee(num_nem.ceil)
        end

        sum + [1, tmp_fee - supply_related_adjustment].max
      end
    end
  end
end
