class Nis::Transaction
  # @attr [Integer] timeStamp
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [Nis::Struct::TransferTransaction] otherTrans
  # @see http://bob.nem.ninja/docs/#multisigTransaction
  class Multisig
    include Nis::Mixin::Network
    attr_writer :version, :fee

    include Nis::Util::Assignable
    attr_accessor :timeStamp, :type, :deadline, :signer,
                  :otherTrans

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias other_trans otherTrans
    alias other_trans= otherTrans=

    TYPE = 0x1004 # 4099 (multisig transaction)
    FEE  = 6_000_000

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def type
      @type ||= TYPE
    end

    # @return [Integer]
    def fee
      @fee ||= FEE
    end

    def mosaics
      @mosaics ||= []
    end

    alias to_hash_old to_hash

    def to_hash
      type
      fee
      to_hash_old
    end
  end
end
