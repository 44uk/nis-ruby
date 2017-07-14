class Nis::Transaction
  # @attr [String]  remoteAccount
  # @attr [Integer] mode
  # @attr [Integer] type
  # @attr [Integer] fee
  # @attr [Integer] deadline
  # @attr [Integer] timeStamp
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [String] signature
  # @attr [Symbol] network
  # @see http://bob.nem.ninja/docs/#importanceTransferTransaction
  class ImportanceTransfer
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :mode, :remoteAccount,
      :deadline, :timeStamp, :version, :signer, :signature,
      :network

    alias remote_account remoteAccount
    alias remote_account= remoteAccount=
    alias timestamp timeStamp

    TYPE = 0x0801 # 2049 (importance transfer transaction)

    ACTIVATE   = 0x0001
    DEACTIVATE = 0x0002

    def initialize(remote_account, mode, network: :testnet)
      @type = TYPE
      @network = network

      @remoteAccount = remote_account
      @mode = parse_mode(mode)
      @fee = Nis::Fee::ImportanceTransfer.new(self)
    end

    private

    def parse_mode(mode)
      case mode
      when :activate   then ACTIVATE
      when :deactivate then DEACTIVATE
        else raise "Not implemented mode: #{mode}"
      end
    end
  end
end
