class Nis::Struct
  # @attr [Integer] timeStamp
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [Nis::Struct::TransferTransaction] otherTrans
  # @see http://bob.nem.ninja/docs/#multisigTransaction
  class MultisigTransaction
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :fee, :type, :deadline, :version, :signer,
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
    def _version
      (0xFFFFFFF0 & @version)
    end

    # @return [Boolean]
    def testnet?
      (0x0000000F & @version) == TESTNET
    end

    # @return [Boolean]
    def mainnet?
      (0x0000000F & @version) == MAINNET
    end

    # @return [Integer]
    def fee
      @fee ||= calculate_fee
    end

    def mosaics
      @mosaics ||= []
    end

    alias to_hash_old to_hash

    def to_hash
      fee
      to_hash_old
    end

    # @return [Integer]
    def calculate_fee
      FEE
    end
  end
end
