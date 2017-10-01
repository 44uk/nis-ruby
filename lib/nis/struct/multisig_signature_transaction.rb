class Nis::Struct
  # @attr [String] other_hash
  # @attr [String] other_account
  class MultisigSignatureTransaction < Transaction
    attr_accessor :otherHash, :otherAccount

    alias :other_hash :otherHash
    alias :other_hash= :otherHash=
    alias :other_account :otherAccount
    alias :other_account= :otherAccount=
  end
end
