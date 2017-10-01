class Nis::Struct
  # @attr [String] other_hash
  # @attr [String] other_account
  class MultisigTransaction < Transaction
    attr_accessor :otherTrans

    alias :other_trans :otherTrans
    alias :other_trans= :otherTrans=

    def self.build(attrs)
      attrs[:otherTrans] = Nis::Struct::TransactionMetaDataPair.build_transaction_struct(attrs[:otherTrans])
      new(attrs)
    end
  end
end
