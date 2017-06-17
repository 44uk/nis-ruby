class Nis::Transaction
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
  class ImportanceTransfer
    include Nis::Mixin::Network
    attr_writer :version, :fee

    include Nis::Util::Assignable
    attr_accessor :timeStamp, :signature, :mode, :remoteAccount, :type, :deadline, :signer

    alias timestamp timeStamp
    alias timestamp= timeStamp=
    alias remote_account remoteAccount
    alias remote_account= remoteAccount=

    TYPE = 0x0801 # 2049 (importance transfer transaction)
    FEE  = 6_000_000

    ACTIVATE   = 0x0001
    DEACTIVATE = 0x0002

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

    alias to_hash_old to_hash

    def to_hash
      type
      fee
      to_hash_old
    end
  end
end
