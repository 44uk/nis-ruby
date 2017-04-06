class Nis::Struct
  # @attr []
  # @attr []
  # @see http://bob.nem.ninja/docs/#unconfirmedTransactionMetaDataPair
  class UnconfirmedTransactionMetaDataPair
    include Nis::Util::Assignable
    attr_accessor :meta, :transaction

    def self.build(attrs)
      new(
        meta: UnconfirmedTransactionMetaData.build(attrs[:meta]),
        transaction: Transaction.build(attrs[:transaction])
      )
    end
  end
end
