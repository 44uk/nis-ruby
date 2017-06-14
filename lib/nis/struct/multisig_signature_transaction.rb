class Nis::Struct
  # @attr [Integer] timeStamp
  # @attr [String]  signature
  # @attr [Integer] fee
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String]  signer
  # @attr [String]  otherHash
  # @attr [String]  otherAccount
  # @see http://bob.nem.ninja/docs/#multisigSignatureTransaction
  class MultisigSignatureTransaction
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :fee, :type, :deadline, :version, :signer,
                  :otherHash, :otherAccount

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias other_hash otherHash
    alias other_hash= otherHash=
    alias other_account otherAccount
    alias other_account= otherAccount=

    TYPE = 0x1002 # 4098 (multisig signature transaction)

    def self.build(attrs)
      new(attrs)
    end

    # @return [Integer]
    def type
      TYPE
    end

    # @return [Integer]
    def _version
      (0xFFFFFFF0 & @version)
    end

    # @return [Boolean]
    def testnet?
      (0x0000000F & @version) == Nis::Util::TESTNET
    end

    # @return [Boolean]
    def mainnet?
      (0x0000000F & @version) == Nis::Util::MAINNET
    end
  end
end
