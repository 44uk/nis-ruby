class Nis::Transaction
  # @attr [Nis::Transaction::*] otherTrans
  # @attr [String] signer
  # @attr [Integer] type
  # @attr [Integer] fee
  # @attr [Integer] deadline
  # @attr [Integer] timeStamp
  # @attr [Integer] version
  # @see https://nemproject.github.io/#multisigTransaction
  class Multisig
    include Nis::Mixin::Struct

    attr_reader :type, :fee
    attr_accessor :otherTrans, :signer,
      :deadline, :timeStamp, :version,
      :network

    alias other_trans otherTrans
    alias other_trans= otherTrans=
    alias timestamp timeStamp

    TYPE = 0x1004 # 4100 (multisig transaction)

    def initialize(tx, signer, network: :testnet)
      @type = TYPE
      @network = network

      @otherTrans = tx
      @signer = signer
      @fee = Nis::Fee::Multisig.new(self)
    end
  end
end
