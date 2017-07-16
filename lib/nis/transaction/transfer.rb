class Nis::Transaction
  # @attr [String]  recipient
  # @attr [Integer] amount
  # @attr [Nis::Struct::Message] message
  # @attr [Array <Nis::Struct::MosaicId>] mosaics
  # @attr [Integer] type
  # @attr [Nis::Fee::Transfer] fee
  # @attr [Integer] deadline
  # @attr [Integer] timestamp
  # @attr [Integer] version
  # @attr [String] signer
  # @attr [Symbol] network
  # @see http://bob.nem.ninja/docs/#transferTransaction
  # @see http://bob.nem.ninja/docs/#initiating-a-transfer-transaction
  # @see http://bob.nem.ninja/docs/#version-1-transfer-transactions
  # @see http://bob.nem.ninja/docs/#version-2-transfer-transactions
  class Transfer
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :recipient, :amount, :message,
      :deadline, :timeStamp, :version, :signer,
      :network

    alias timestamp timeStamp

    TYPE = 0x0101 # 257 (transfer transaction)

    def initialize(recipient, amount, message = '', network: :testnet)
      @type = TYPE
      @network = network

      @recipient = recipient
      @amount = amount
      @message = Nis::Struct::Message.new(message)
      @fee = Nis::Fee::Transfer.new(self)
    end

    def mosaics
      # TODO: to be implemented...
      []
    end
  end
end
