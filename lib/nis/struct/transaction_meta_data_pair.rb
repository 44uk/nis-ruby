class Nis::Struct
  # @attr []
  # @attr []
  # @attr []
  # @attr []
  # @attr []
  # @see http://bob.nem.ninja/docs/#transactionMetaDataPair
  class TransactionMetaDataPair
    include Nis::Util::Assignable
    attr_accessor :meta, :transaction

    def self.build(meta:, transaction:)
      new(
        meta: TransactionMetaData.build(meta),
        transaction: Transaction.build(transaction)
      )
    end
  end
end
