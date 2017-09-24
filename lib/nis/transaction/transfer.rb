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
  # @see https://nemproject.github.io/#transferTransaction
  # @see https://nemproject.github.io/#initiating-a-transfer-transaction
  # @see https://nemproject.github.io/#version-1-transfer-transactions
  # @see https://nemproject.github.io/#version-2-transfer-transactions
  class Transfer
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :recipient, :amount, :message,
      :deadline, :timeStamp, :version, :signer,
      :network,
      :mosaics

    alias timestamp timeStamp

    TYPE = 0x0101 # 257 (transfer transaction)

    def initialize(recipient, amount, message = '', mosaics: [], network: :testnet)
      @type = TYPE
      @network = network

      @recipient = recipient
      @amount = amount
      @message = message.is_a?(Nis::Struct::Message) ?
        message :
        Nis::Struct::Message.new(message.to_s)
      @fee = Nis::Fee::Transfer.new(self)
      @mosaics = mosaics
    end

    def has_message?
      @message.bytesize > 0
    end

    def has_mosaics?
      @mosaics.size > 0
    end
  end
end
