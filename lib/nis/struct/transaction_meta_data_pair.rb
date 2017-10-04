class Nis::Struct
  # @attr [Nis::Struct::TransactionMetaData] meta
  # @attr [Nis::Struct::Transaction] transaction
  # @see https://nemproject.github.io/#transactionMetaDataPair
  class TransactionMetaDataPair
    include Nis::Util::Assignable
    attr_accessor :meta, :transaction

    def self.build(meta:, transaction:)
      new(
        meta: TransactionMetaData.build(meta),
        transaction: build_transaction_struct(transaction)
      )
    end

    def self.build_transaction_struct(data)
      type = data[:type]
      klass = case type
              when 0x0101 then Nis::Struct::TransferTransaction
              when 0x0801 then Nis::Struct::ImportanceTransferTransaction
              when 0x1001 then Nis::Struct::MultisigAggregationModificationTransaction
              when 0x1002 then Nis::Struct::MultisigSignatureTransaction
              when 0x1004 then Nis::Struct::MultisigTransaction
              when 0x2001 then Nis::Struct::ProvisionNamespaceTransaction
              when 0x4001 then Nis::Struct::MosaicDefinitionCreationTransaction
              when 0x4002 then Nis::Struct::MosaicSupplyChangeTransaction
        else raise "Not implemented entity type: #{type}"
      end
      klass.build(data)
    end
  end
end
