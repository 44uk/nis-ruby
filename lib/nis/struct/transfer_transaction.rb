class Nis::Struct
  # @attr [String]  recipient
  # @attr [Integer] amount
  # @attr [Nis::Struct::Message] message
  # @attr [Array <Nis::Struct::MosaicId>] mosaics
  # @see https://nemproject.github.io/#version-1-transfer-transactions
  # @see https://nemproject.github.io/#version-2-transfer-transactions
  class TransferTransaction < Transaction
    attr_accessor :recipient, :amount, :message, :mosaics
  end
end
