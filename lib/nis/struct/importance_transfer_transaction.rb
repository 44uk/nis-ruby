class Nis::Struct
  # @attr [Integer] timeStamp
  # @attr [String]  signature
  # @attr [Integer] fee
  # @attr [Integer] mode
  # @attr [String]  remoteAccount
  # @attr [Integer] type
  # @attr [Integer] deadline
  # @attr [Integer] version
  # @attr [String]  signer
  # @see http://bob.nem.ninja/docs/#importanceTransferTransaction
  class ImportanceTransferTransaction
    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :fee, :mode, :remoteAccount, :type, :deadline, :version, :signer

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias remote_account remoteAccount
    alias remote_account= remoteAccount=

    TYPE = 0x0801 # 2049 (importance transfer transaction)

    ACTIVATE   = 0x0001
    DEACTIVATE = 0x0002

    def self.build(attrs)
      new(attrs)
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
